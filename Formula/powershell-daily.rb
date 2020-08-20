# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.
class PowershellDaily < Formula
  desc "PowerShell Daily"
  homepage "https://github.com/powershell/powershell"
  # We do not specify `version "..."` as 'brew audit' will complain - see https://github.com/Homebrew/legacy-homebrew/issues/32540
  url "https://pscoretestdata.blob.core.windows.net/v7-1-0-daily-20200820/powershell-7.1.0-daily.20200820-osx-x64.tar.gz"
  version "7.1.0-daily.20200820"
  # must be lower-case
  sha256 "dad13d71509d9e59e06e7b423044ac3535cf3e0dfc98e17c5d8da8ef68e8a67e"
  version_scheme 1
  bottle :unneeded

  # .NET Core 3.1 requires High Sierra - https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?pivots=os-macos&tabs=netcore31
  depends_on macos: :high_sierra

  def install
    libexec.install Dir["*"]
    chmod 0555, libexec/"pwsh"
    bin.install_symlink libexec/"pwsh" => "pwsh-daily"
  end

  def caveats
    <<~EOS
      The executable should already be on PATH so run with `pwsh-daily`. If not, the full path to the executable is:
        #{bin}/pwsh-daily

      Other application files were installed at:
        #{libexec}

      If you would like to make PowerShell you shell, run
        sudo echo '#{bin}/pwsh-daily' >> /etc/shells
        chsh -s #{bin}/pwsh-daily
    EOS
  end

  test do
    assert_equal "7.1.0-daily.20200820",
      shell_output("#{bin}/pwsh-daily -c '$psversiontable.psversion.tostring()'").strip
  end
end
