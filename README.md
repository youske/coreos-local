coreos-local
============

# 概要
coreosをベースにしたローカル環境の構築
coreosを起動し、sshアクセスを行うことができるところまでをサポート

Dockerイメージによるコンテナ作成は<url>を用いて行う。
coreos起動直後にcoreos内でgit cloneを行い
必要なDockerfileを実行し環境設定を行う。
