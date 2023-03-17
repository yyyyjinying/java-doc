安装 20.10.12
- brew install --cask --appdir=/Applications docker

{
  "registry-mirrors": [
    "https://qp7hg0gh.mirror.aliyuncs.com"
  ],
  "features": {
    "buildkit": true
  },
  "experimental": false,
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  }
}