class Crew < Formula
  desc "Run many Claude Code sessions in parallel across branches and projects"
  homepage "https://github.com/AryanAg08/crew"
  url "https://github.com/AryanAg08/crew/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4b0581a7cbdf3eb45b4276529113d94bd7e020812f4d69e33a31f1ed3f74a73b"
  license "Apache-2.0"
  head "https://github.com/AryanAg08/crew.git", branch: "main"

  depends_on "go" => :build
  # Every session is a tmux session, and the sidebar is a tmux pane.
  depends_on "tmux"
  depends_on :macos

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "."
  end

  def caveats
    <<~EOS
      crew runs Claude Code, which Homebrew doesn't install. Make sure `claude`
      is on your PATH: https://claude.com/claude-code

      Then run:
        crew
    EOS
  end

  test do
    assert_match "crew #{version}", shell_output("#{bin}/crew --version")
  end
end
