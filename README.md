# MURPHY's AI Chat Application

A Flutter-based chat application that leverages GROQ's powerful language models to provide an interactive AI chat experience with advanced image capabilities.

## Features

- **Text Conversations**: Natural language interaction with GROQ's LLaMA models
- **Image Analysis**: Send images to receive AI descriptions and analysis
- **Image Generation**: Request images through text prompts with "/generate" command
- **Modern UI**: Clean, intuitive interface with real-time message updates

## Screenshots

*[Add your app screenshots here]*

## Installation

1. Clone the repository:
```bash
git clone https://github.com/SHIHAB69/murphys-ai.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

## Usage

### Text Conversation
Simply type your message in the input field and tap the send button.

### Image Analysis
1. Tap the photo icon in the input bar
2. Select an image from your gallery
3. Add an optional question about the image (or leave blank)
4. Send to receive AI analysis of your image

### Image Generation
1. Type a message starting with "/generate" followed by your description
2. Example: `/generate a mountain landscape at sunset`
3. The AI will provide a matching image

## Configuration

The application uses GROQ's API with the following models:
- `llama-3.2-90b-vision-preview`: For image analysis
- `llama-3.3-70b-versatile`: For general text interactions

You can adjust model parameters in the service files:
- `temperature`: Controls creativity (lower for more consistent responses)
- `max_tokens`: Maximum output length

## Dependencies

- `flutter`: UI framework
- `dio`: API communication
- `image_picker`: Image selection functionality
- `path_provider`: File system operations
- `http`: Additional HTTP capabilities

## API Reference

This application uses GROQ's API. You'll need to update the API key in the service files before using the app:

```dart
final String _apiKey = 'Bearer YOUR_GROQ_API_KEY';
```

## Roadmap

- Add conversation history storage
- Support for voice input
- Custom styling options
- Multiple language support

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

[Add your license information here]

## Acknowledgemen
https://www.canva.com/design/DAGhY-qXgF0/msFshUuVjJskTpxa4XOUiQ/edit

- [GROQ](https://groq.com) for providing the AI models
- The Flutter community for their excellent packages
