class Upyr < Formula
  desc "Private English-Ukrainian keyboard-layout fixer"
  homepage "https://upyr.org/"
  url "https://github.com/dmytro-yemelianov/upyr/archive/bf3d1dea052cf2bc5b5085ca4ffd3546c79398fa.tar.gz"
  version "0.3.0"
  sha256 "c90d565bf71674c1b69d7a750c19393a9e24ae48a8f2b66d5692f5be2b688c69"
  license "MIT"
  head "https://github.com/dmytro-yemelianov/upyr.git", branch: "main"

  depends_on "rust" => :build

  on_linux do
    depends_on "dbus"
    depends_on "libx11"
    depends_on "libxkbcommon"
    depends_on "libxtst"
  end

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  service do
    run [opt_bin/"upyr-background"]
    keep_alive true
    log_path var/"log/upyr.log"
    error_log_path var/"log/upyr.log"
  end

  def caveats
    <<~EOS
      Upyr's CLI is installed as:
        #{opt_bin}/upyr

      Start the background layout fixer with:
        brew services start upyr

      Open settings with:
        #{opt_bin}/upyr settings

      On macOS, grant Accessibility permission to the Upyr background process
      when prompted. The Homebrew formula builds from source and does not install
      an Apple-notarized .app bundle.
    EOS
  end

  test do
    assert_equal "привіт", shell_output("#{bin}/upyr convert ghbdsn").strip
  end
end
