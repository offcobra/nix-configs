{ ... }:

{
  # Ollama AI service
  services.ollama = {
    enable = true;
    # 127.0.0.1:11434 -> Listening Address
    #acceleration = "rocm";
  };

}
