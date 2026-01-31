class SecurityToolkit < Formula
  desc "Security verification toolkit for NIST compliance scanning"
  homepage "https://github.com/brucedombrowski/security-toolkit"
  url "https://github.com/brucedombrowski/security-toolkit/archive/refs/tags/v2.0.5.tar.gz"
  sha256 "6d04f1a85179fbc2c93d6459b17bf47836b4ebd48c71141f5d364e51518bce37"
  license "MIT"
  head "https://github.com/brucedombrowski/security-toolkit.git", branch: "main"

  depends_on "jq"
  depends_on "clamav" => :recommended

  def install
    # Install all scripts to libexec
    libexec.install Dir["scripts/*"]
    libexec.install "data"

    # Install documentation
    doc.install "README.md", "CHANGELOG.md", "LICENSE"
    doc.install Dir["docs/*"]

    # Create wrapper scripts in bin
    (bin/"security-scan").write_env_script libexec/"run-all-scans.sh",
      SECURITY_TOOLKIT_HOME: libexec

    (bin/"security-tui").write_env_script libexec/"tui.sh",
      SECURITY_TOOLKIT_HOME: libexec

    (bin/"security-inventory").write_env_script libexec/"collect-host-inventory.sh",
      SECURITY_TOOLKIT_HOME: libexec

    (bin/"security-pii").write_env_script libexec/"check-pii.sh",
      SECURITY_TOOLKIT_HOME: libexec

    (bin/"security-secrets").write_env_script libexec/"check-secrets.sh",
      SECURITY_TOOLKIT_HOME: libexec

    (bin/"security-malware").write_env_script libexec/"check-malware.sh",
      SECURITY_TOOLKIT_HOME: libexec

    (bin/"security-kev").write_env_script libexec/"check-kev.sh",
      SECURITY_TOOLKIT_HOME: libexec

    (bin/"security-containers").write_env_script libexec/"check-containers.sh",
      SECURITY_TOOLKIT_HOME: libexec
  end

  def caveats
    <<~EOS
      Security Verification Toolkit installed!

      Commands available:
        security-scan       Run all security scans
        security-tui        Interactive menu interface
        security-inventory  Collect host system inventory
        security-pii        Scan for PII patterns
        security-secrets    Scan for hardcoded secrets
        security-malware    Run ClamAV malware scan
        security-kev        Check against CISA KEV catalog
        security-containers Scan running containers

      Usage:
        security-scan /path/to/project
        security-tui

      For ClamAV malware scanning, update virus definitions:
        freshclam

      Documentation: #{doc}
    EOS
  end

  test do
    # Test that scripts are executable
    assert_predicate bin/"security-scan", :executable?
    assert_predicate bin/"security-tui", :executable?

    # Test help output
    output = shell_output("#{bin}/security-pii --help 2>&1 || true")
    assert_match(/PII|scan|usage/i, output)

    # Test KEV catalog exists
    assert_predicate libexec/"data/kev-catalog.json", :exist?
  end
end
