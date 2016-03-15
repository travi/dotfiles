# Download chocolatey install
iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))

cinst git -y
cinst ConEmu -y
cinst SourceCodePro -y

cinst ruby -y

cinst vim -y
cinst atom -y
