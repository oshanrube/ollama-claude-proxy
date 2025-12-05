# Ollama to Claude API Proxy

A Python application that serves as a proxy between Ollama API interface and Anthropic's Claude API. This enables IDE plugins and tools that support Ollama to work seamlessly with Claude models.

## Author

**Philip Senger** - [psenger](https://github.com/psenger)
- Linkedin: [philipsenger](https://www.linkedin.com/in/philipsenger/)

## Features

- **Full Ollama API Compatibility**: Implements the essential Ollama endpoints
- **Claude 4 Model Support**: Access to the latest Claude 4 models through familiar Ollama interface
- **Dual Backend Support**: Works with both Anthropic API and Google Vertex AI
- **Easy Model Mapping**: Simple configuration for mapping Ollama model names to Claude models
- **Environment-based Configuration**: Simple setup using environment variables
- **Comprehensive Logging**: Detailed logging for debugging and monitoring

## Supported Endpoints

- `GET /` - Health check endpoint
- `GET /api/tags` - Lists available models
- `POST /api/chat` - Chat completions
- `POST /api/show` - Model details

## Model Mappings

The following Ollama model names are mapped to Claude 4 models:

| Ollama Model Name        | Claude Model               |
|--------------------------|----------------------------|
| `claude-4-sonnet`        | `claude-4-sonnet-20250514` |
| `claude-4-sonnet:latest` | `claude-4-sonnet-20250514` |
| `claude-4-opus`          | `claude-4-opus-20250514`   |
| `claude-4-opus:latest`   | `claude-4-opus-20250514`   |
| `claude-sonnet`          | `claude-4-sonnet-20250514` |
| `claude-opus`            | `claude-4-opus-20250514`   |

## Installation

### Prerequisites

- Python 3.9 or higher
- **Either** an Anthropic API key **OR** Google Cloud Platform account with Vertex AI enabled

### Option 1: Using Anthropic API (Direct)

#### Setup Steps

1. **Clone or download the project files**:
   ```bash
   # Create project directory
   mkdir ollama-claude-proxy
   cd ollama-claude-proxy
   
   # Copy the main.py and requirements.txt files to this directory
   ```

2. **Create and activate a virtual environment** (recommended):
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

4. **Set environment variables**:
   ```bash
   # Required: Your Anthropic API key
   export ANTHROPIC_API_KEY="your-anthropic-api-key-here"
   
   # Optional: Custom port (default is 11434)
   export FLASK_PORT=11434
   ```

   On Windows (Command Prompt):
   ```cmd
   set ANTHROPIC_API_KEY=your-anthropic-api-key-here
   set FLASK_PORT=11434
   ```

   On Windows (PowerShell):
   ```powershell
   $env:ANTHROPIC_API_KEY="your-anthropic-api-key-here"
   $env:FLASK_PORT="11434"
   ```

5. **Run the application**:
   ```bash
   python main.py
   ```

The server will start and display:
```
Starting Ollama-to-Claude proxy server on port 11434
Available models: ['claude-4-sonnet', 'claude-4-sonnet:latest', 'claude-4-opus', 'claude-4-opus:latest', 'claude-sonnet', 'claude-opus']
```

### Option 2: Using Google Vertex AI

#### Prerequisites

1. **Google Cloud Project** with billing enabled
2. **Vertex AI API** enabled in your project
3. **Access to Claude models** on Vertex AI (may require requesting access)
4. **Allocated quota** in your desired region
5. **Google Cloud SDK** (`gcloud`) installed and configured

#### Setup Steps

1. **Install Google Cloud SDK** (if not already installed):
   ```bash
   # Follow instructions at: https://cloud.google.com/sdk/docs/install
   ```

2. **Authenticate with Google Cloud**:
   ```bash
   gcloud auth application-default login
   ```

3. **Set your project**:
   ```bash
   gcloud config set project YOUR_PROJECT_ID
   ```

4. **Enable Vertex AI API**:
   ```bash
   gcloud services enable aiplatform.googleapis.com
   ```

5. **Clone or download the project files** (same as Option 1):
   ```bash
   mkdir ollama-claude-proxy
   cd ollama-claude-proxy
   ```

6. **Create and activate a virtual environment**:
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

7. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

8. **Set environment variables**:
   ```bash
   # Required: Enable Vertex AI mode
   export USE_VERTEX_AI=1

   # Required: Your Google Cloud Project ID
   export VERTEX_PROJECT_ID="your-project-id"

   # Optional: Vertex AI region (default: us-east5)
   export VERTEX_REGION="us-east5"

   # Optional: Custom port (default is 11434)
   export FLASK_PORT=11434
   ```

   On Windows (Command Prompt):
   ```cmd
   set USE_VERTEX_AI=1
   set VERTEX_PROJECT_ID=your-project-id
   set VERTEX_REGION=us-east5
   set FLASK_PORT=11434
   ```

   On Windows (PowerShell):
   ```powershell
   $env:USE_VERTEX_AI="1"
   $env:VERTEX_PROJECT_ID="your-project-id"
   $env:VERTEX_REGION="us-east5"
   $env:FLASK_PORT="11434"
   ```

9. **Run the application**:
   ```bash
   python proxy.py
   ```

**Important Notes for Vertex AI**:
- Authentication is handled automatically through Google Cloud credentials
- Available models and regions may vary - check [Vertex AI documentation](https://cloud.google.com/vertex-ai/docs/generative-ai/model-reference/claude)
- You may need to request access to Claude models in your project
- Supported regions include: `us-east5`, `europe-west1`, `asia-southeast1`, and others

## Configuration

### Environment Variables

#### For Anthropic API (Direct)

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `ANTHROPIC_API_KEY` | ✅ Yes | - | Your Anthropic API key |
| `FLASK_PORT` | ❌ No | `11434` | Port number for the server |

#### For Vertex AI

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `USE_VERTEX_AI` | ✅ Yes | - | Set to `1`, `true`, or `yes` to enable Vertex AI mode |
| `VERTEX_PROJECT_ID` | ✅ Yes | - | Your Google Cloud Project ID |
| `VERTEX_REGION` | ❌ No | `us-east5` | Vertex AI region |
| `FLASK_PORT` | ❌ No | `11434` | Port number for the server |

### Getting an Anthropic API Key

1. Sign up at [https://console.anthropic.com/](https://console.anthropic.com/)
2. Navigate to the API Keys section
3. Create a new API key
4. Copy the key and set it as the `ANTHROPIC_API_KEY` environment variable

## Docker Usage

### Building the Docker Image

```bash
docker build -t ollama-claude-proxy .
```

### Running with Anthropic API

```bash
docker run -p 11434:11434 \
  -e ANTHROPIC_API_KEY=your-api-key-here \
  ollama-claude-proxy
```

Or in detached mode:
```bash
docker run -d -p 11434:11434 \
  -e ANTHROPIC_API_KEY=your-api-key-here \
  --name ollama-claude-proxy \
  ollama-claude-proxy
```

### Running with Vertex AI

For Vertex AI, you need to mount your Google Cloud credentials:

```bash
docker run -p 11434:11434 \
  -e USE_VERTEX_AI=1 \
  -e VERTEX_PROJECT_ID=your-project-id \
  -e VERTEX_REGION=us-east5 \
  -v $HOME/.config/gcloud:/root/.config/gcloud:ro \
  ollama-claude-proxy
```

Or using a service account key file:

```bash
docker run -p 11434:11434 \
  -e USE_VERTEX_AI=1 \
  -e VERTEX_PROJECT_ID=your-project-id \
  -e VERTEX_REGION=us-east5 \
  -e GOOGLE_APPLICATION_CREDENTIALS=/app/credentials.json \
  -v /path/to/your/service-account-key.json:/app/credentials.json:ro \
  ollama-claude-proxy
```

**Note**: For production deployments with Vertex AI, using a service account key file is recommended.

## Usage

### With IDE Plugins

Configure your IDE's Ollama plugin to use the proxy URL:
```
http://localhost:11434
```

Popular IDE plugins that work with this proxy:
- **JetBrains IDEs**: Ollama plugin
- **VS Code**: Various Ollama extensions
- **Neovim**: Ollama.nvim

### Direct API Usage

You can also interact with the proxy directly using HTTP requests:

#### List Models
```bash
curl http://localhost:11434/api/tags
```

#### Chat Completion
```bash
curl -X POST http://localhost:11434/api/chat \
  -H "Content-Type: application/json" \
  -d '{
    "model": "claude-sonnet",
    "messages": [
      {"role": "user", "content": "Hello, how are you?"}
    ],
    "options": {
      "temperature": 0.7
    }
  }'
```

#### Model Details
```bash
curl -X POST http://localhost:11434/api/show \
  -H "Content-Type: application/json" \
  -d '{"name": "claude-sonnet"}'
```

## API Request/Response Examples

### Chat Completion Request
```json
{
  "model": "claude-sonnet",
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant."
    },
    {
      "role": "user",
      "content": "Explain quantum computing in simple terms."
    }
  ],
  "options": {
    "temperature": 0.7,
    "top_p": 0.9,
    "max_tokens": 1000
  }
}
```

### Chat Completion Response
```json
{
  "model": "claude-sonnet",
  "created_at": "2024-06-06T10:30:00Z",
  "message": {
    "role": "assistant",
    "content": "Quantum computing is a revolutionary approach to computation..."
  },
  "done": true,
  "total_duration": 0,
  "load_duration": 0,
  "prompt_eval_count": 25,
  "eval_count": 150,
  "eval_duration": 0
}
```

## Troubleshooting

### Common Issues

1. **API Key Not Set**:
   ```
   ValueError: ANTHROPIC_API_KEY environment variable is required
   ```
   **Solution**: Set the `ANTHROPIC_API_KEY` environment variable.

2. **Port Already in Use**:
   ```
   OSError: [Errno 48] Address already in use
   ```
   **Solution**: Either stop the service using port 11434 or set a different port using `FLASK_PORT`.

3. **Claude API Errors**:
   ```
   Claude API error: 401 Unauthorized
   ```
   **Solution**: Verify your API key is correct and has sufficient credits.

4. **Model Not Found**:
   ```
   Model not found in mapping
   ```
   **Solution**: Use one of the supported model names listed in the mapping table.

### Logging

The application provides detailed logging. Check the console output for:
- Server startup information
- Request/response details
- Error messages with stack traces

### Testing the Installation

After starting the server, test it with:

```bash
# Test health check
curl http://localhost:11434/

# Test model listing
curl http://localhost:11434/api/tags

# Test simple chat
curl -X POST http://localhost:11434/api/chat \
  -H "Content-Type: application/json" \
  -d '{"model": "claude-sonnet", "messages": [{"role": "user", "content": "Hello"}]}'
```

## Development

### Project Structure
```
ollama-claude-proxy/
├── CONTRIBUTING.md    # How to contribute
├── Dockerfile         # Docker
├── LICENSE            # Liscense
├── README.md          # This file
├── proxy.py           # Main application file
├── requirements.txt   # Python dependencies      
└── venv/              # Virtual environment (created during setup)
```

### Adding New Models

To add support for new Claude models, update the `OLLAMA_TO_CLAUDE_MAPPING` dictionary in `main.py`:

```python
OLLAMA_TO_CLAUDE_MAPPING = {
    # Existing mappings...
    'new-model-name': 'claude-actual-model-id',
}
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

* Thanks to Anthropic for their Claude API
* Thanks to the Ollama team for their API design
* All the contributors who have helped improve this project