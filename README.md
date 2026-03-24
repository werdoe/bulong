# Bulong

> **The invisible whisper in your ear.**

A real-time AI meeting copilot that transcribes, searches your knowledge, and surfaces what you need to say — right when you need it. Nobody on the call knows it's there.

*Bulong (Tagalog): to whisper*

[![macOS](https://img.shields.io/badge/macOS-Apple%20Silicon-black?logo=apple)](https://support.apple.com/en-us/116943)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Swift](https://img.shields.io/badge/Swift-6.2-orange?logo=swift)](https://swift.org)

---

## What it does

You start a call. Bulong listens. While you talk, it:

- **Transcribes** both sides of the conversation in real-time — locally, on your Mac
- **Searches your knowledge base** — notes, SOPs, client docs, past call transcripts
- **Surfaces suggestions** — talking points, data, and context when the conversation needs it
- **Remembers participants** — who they are, what you discussed last time, their preferences
- **Answers your questions** — type anything mid-call, get instant answers from your KB + the web
- **Searches the internet** — fact-checks claims, pulls live data, finds references
- **Summarizes** — action items, decisions, and follow-ups after every call
- **Builds memory** — every call makes the next one smarter

All while being **completely invisible** to the other side. Hidden from screen sharing. No bot joins the call. No one knows.

---

## Privacy first

- 🔒 **Audio never leaves your Mac** — transcription runs 100% locally (Whisper)
- 🏠 **Fully offline mode** — pair with Ollama for zero network calls
- 👻 **Hidden from screen share** — the window is invisible to capture by default
- 🔑 **API keys in macOS Keychain** — not config files
- 📁 **Transcripts saved locally** — your data, your machine

---

## How it works

1. Start your call (Zoom, Meet, Teams, phone — anything)
2. Click **Live** in Bulong
3. Talk naturally — Bulong transcribes and listens in the background
4. When a moment matters — a question, a decision, a claim — Bulong searches your knowledge and surfaces what's relevant
5. After the call: full transcript, summary, action items — auto-saved

---

## Features

### Live right now
- Real-time local transcription (both speakers)
- Knowledge base search during calls (point it at a folder of .md/.txt files)
- AI-powered talking point suggestions
- Auto-saved session transcripts
- Multiple LLM support (Ollama local / OpenRouter cloud)

### Coming soon
- 🧠 **Participant memory** — auto-build profiles across calls
- 🔍 **Past call search** — semantic search across all previous conversations
- 🌐 **Live internet search** — fact-check and pull data mid-call
- 💬 **Q&A panel** — ask questions, get instant answers from KB + web + past calls
- 📋 **Client context** — auto-load relevant docs when a call starts
- ✅ **Action item tracking** — follow up across meetings

---

## Install

### Homebrew
```bash
brew tap werdoe/bulong https://github.com/werdoe/bulong
brew install --cask werdoe/bulong/bulong
```

### Manual
Grab the latest `.dmg` from [Releases](https://github.com/werdoe/bulong/releases).

### Build from source
```bash
git clone https://github.com/werdoe/bulong.git
cd bulong
./scripts/build_swift_app.sh
```

---

## Requirements

- Apple Silicon Mac, macOS 15+
- For local mode: [Ollama](https://ollama.com/) running with your preferred model
- For cloud mode: [OpenRouter](https://openrouter.ai/) API key

---

## Setup

1. Launch Bulong and grant microphone + system audio permissions
2. Open Settings (Cmd+,) and pick your LLM provider:
   - **Local:** Select Ollama (everything stays on your machine)
   - **Cloud:** Add your OpenRouter API key
3. Point it at a folder of notes — that's your knowledge base
4. Click **Live** and start your call

---

## Knowledge base

Drop your `.md` or `.txt` files in a folder. Bulong chunks, embeds, and caches them. During calls, it searches your notes and only surfaces what's relevant.

Works great with:
- Meeting prep docs
- Client briefs and SOPs
- Competitive analysis
- Research notes
- Past call transcripts

---

## Legal notice

Bulong records and transcribes audio. Many jurisdictions require consent from participants before recording. You are responsible for knowing and following your local laws. See [LICENSE](LICENSE) for details.

---

## Credits

Built on top of [OpenOats](https://github.com/yazinsai/OpenOats) by yazinsai. Enhanced with participant memory, internet search, past-call intelligence, and a redesigned UI.

---

**Bulong** — *the invisible whisper in your ear.*
