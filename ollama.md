# Ollama

`pacman -S ollama`

`systemctl start ollama`

> gemin recomendation (which I did not ask for)

# Pull the high-performance Qwen 2.5 Coder (7B is the sweet spot)
`ollama run qwen2.5-coder:3b`

> generally smaller models are considered faster.
> using the 3b as ref and measurement for how much vram is required.

`ollama list` to check installs
check server is listening:
`curl http://localhost:11434/api/tags`
real world test:
```bash
curl http://localhost:11434/api/generate -d '{
  "model": "qwen2.5-coder:7b",
  "prompt": "Write a hello world in Rust",
  "stream": false
}'
```
