class Upyr < Formula
  desc "Private English-Ukrainian keyboard-layout fixer"
  homepage "https://upyr.org/"
  url "https://crates.io/api/v1/crates/upyr/0.3.0/download"
  version "0.3.0"
  sha256 "8613dd8ffe204125abf366714004966cc8ddfd1a9ff7aab3fdea93d04b026b75"
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
