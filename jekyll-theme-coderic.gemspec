# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-theme-coderic"
  spec.version       = "0.2.1"
  spec.authors       = ["Neftali Yagua"]
  spec.email         = ["neftali.yagua@coderic.org"]

  spec.summary       = "A premium, accessible Jekyll theme for enterprise portals and documentation."
  spec.homepage      = "https://github.com/Coderic/jekyll-theme-coderic"
  spec.license       = "MIT"

  # Páginas OAuth/API en la raíz: deben ir en el gem/remoto para que existan /callback/, /profile/, /hello-world/.
  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_data|_layouts|_includes|_sass|LICENSE|README|robots\.txt|sitemap\.xml|_config\.yml|callback\.html|profile\.html|hello-world\.html)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.4"
  spec.add_runtime_dependency "jekyll-polyglot", "~> 1.12"
  spec.add_runtime_dependency "logger"
end
