# WhisperKit Transcription Engine

Replace `SFSpeechRecognizer` with WhisperKit for on-device transcription that works without Apple Intelligence.

## Problem

Apple's SpeechAnalyzer crashes on external boot drives. The fallback `SFSpeechRecognizer` works but has limited quality and usage caps.

## Solution

Use WhisperKit (whisper-base, ~140MB CoreML) with a VAD-triggered segmentation layer. Keep existing audio capture pipeline unchanged.

## Architecture

```
MicCapture ──AsyncStream<AVAudioPCMBuffer>──┐
                                             ├──▶ VADSegmenter ──▶ WhisperKit.transcribe()
SystemAudioCapture ──AsyncStream<AVAudioPCMBuffer>──┘                      │
                                                                           ▼
                                                                    TranscriptStore
```

## Components

### VADSegmenter (new)

Sits between audio streams and WhisperKit:

1. Consumes `AsyncStream<AVAudioPCMBuffer>`
2. Resamples to 16kHz mono via `AVAudioConverter`
3. Energy-based VAD detects speech vs silence
4. Accumulates `[Float]` samples during speech
5. Emits completed segments on silence detection

Config: silence threshold, min segment (0.5s), max segment (30s).

### TranscriptionEngine (modified)

- Drop: `SFSpeechRecognizer`, `BufferRelay` actor, Speech framework import
- Add: WhisperKit pipe init, VADSegmenter per audio source
- Init downloads `base` model from HuggingFace on first run
- `assetStatus` reflects model download/ready state
- Two concurrent tasks: mic segments → transcribe(speaker: .you), sys segments → transcribe(speaker: .them)

### Unchanged

- `MicCapture` — AVAudioEngine mic capture with device selection
- `SystemAudioCapture` — ScreenCaptureKit system audio
- `TranscriptStore` — receives Utterance objects as before
- `ContentView` — reads same observable properties
- Audio level metering — still from mic tap

## Dependencies

```swift
.package(url: "https://github.com/argmaxinc/WhisperKit.git", from: "0.9.0")
```

## Model

- whisper-base (~140MB CoreML)
- Auto-downloaded on first launch
- Cached in app support directory
- Platform: macOS 13+ (WhisperKit minimum)

Note: Our Package.swift targets macOS 26. WhisperKit supports macOS 13+, so no conflict.
