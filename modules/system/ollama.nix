# Aspect: ollama -- local AI service (listens on 127.0.0.1:11434).
{
  flake.modules.nixos.ollama = {
    services.ollama.enable = true;
  };
}
