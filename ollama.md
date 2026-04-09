# Ollama

`pacman -S ollama`

`systemctl start ollama`

`ollama run qwen2.5-coder:3b`

`ollama list` to check installs

> generally smaller models are considered faster.
> using the 3b as ref and measurement for how much vram is required.

## AI Gemini Model recommendations

**small**
| Model | Size | Best For | VRAM/RAM Usage |
| :--- | :--- | :--- | :--- |
| **Qwen2.5-Coder 3B** | 3.2B | General "senior" tooling & refactoring. | ~2.5 GB |
| **DeepSeek-V4-Lite** | MoE | Complex logic/multi-file context. | ~4.5 GB |
| **Gemma-4-E2B** | 2.3B | Instant terminal & ACP agent tasks. | ~1.8 GB |


**large**
| Model | Size | Best For | VRAM/RAM Usage |
| :--- | :--- | :--- | :--- |
| **Qwen3-Coder 14B** | 14B | Perfect balance of logic and 144Hz-tier speed. | ~10-12 GB |
| **DeepSeek-V3.2** | MoE | Complex systems, logic-heavy review, and debugging. | ~14 GB |
| **GPT-OSS 20B** | 20B | Maximum speed for agentic "background" tasks. | ~15 GB |


## GPU utilisation

```bash
# nvidia
sudo pacman -S ollama-cuda

# amd
sudo pacman -S ollama-rocm
```

