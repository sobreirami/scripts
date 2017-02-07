#!/bin/bash
#
# Downloads e configuração dos seguintes programas:
#
#   Java JDK
#   Apache Ant
#   Android
#   NPM
#   Apache Cordova
#   Ionic Framework
#   Gradle

HOME_PATH=$(cd ~/ && pwd)
INSTALL_PATH=/opt
ANDROID_SDK_PATH=/opt/android-sdk
NODE_PATH=/opt/node
GRADLE_PATH=/opt/gradle

# Última versão do Android 07/02/2017
ANDROID_SDK="http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz"

# Última versão Node 07/02/2017
NODE="https://nodejs.org/dist/v6.9.5/node-v6.9.5-linux-x64.tar.xz"

# Última versão Gradle 07/02/2017
GRADLE_ALL="https://services.gradle.org/distributions/gradle-3.3-all.zip"

cd ~/

wget -c "$NODE" -O "nodejs.tar.xz" --no-check-certificate
wget -c "$ANDROID_SDK" -O "android-sdk.zip" --no-check-certificate
wget -c "$GRADLE_ALL" -O "gradle.zip" --no-check-certificate

tar xf "nodejs.tar.xz" -C "$INSTALL_PATH"
unzip "android-sdk.zip" -d "$INSTALL_PATH"
unzip "gradle.zip"
mv "gradle-3.3" "$INSTALL_PATH"

cd "$INSTALL_PATH" && mv "android-sdk-linux" "android-sdk"
cd "$INSTALL_PATH" && mv "node-v6.9.5-linux-x64" "node"
cd "$INSTALL_PATH" && mv "gradle-3.3" "gradle"

cd "$INSTALL_PATH" && chown root:root "android-sdk" -R
cd "$INSTALL_PATH" && chmod 777 "android-sdk" -R

# Adicona variável de ambiente ao bashrc
echo "export PATH=\$PATH:$ANDROID_SDK_PATH/tools" >> ".bashrc"
echo "export PATH=\$PATH:$ANDROID_SDK_PATH/platform-tools" >> ".bashrc"
echo "export PATH=\$PATH:$NODE_PATH/bin" >> ".bashrc"
echo "export PATH=\$PATH:$GRADLE_PATH/bin" >> ".bashrc"

# Adicona como temporaria as variável até a o fim da instalação
export PATH=$PATH:$ANDROID_SDK_PATH/tools
export PATH=$PATH:$ANDROID_SDK_PATH/platform-tools
export PATH=$PATH:$NODE_PATH/bin
export PATH=$PATH:$GRADLE_PATH/bin

# Atualizar repositorios
sudo apt-get update

# Instalar java
sudo apt-get install default-jre

# Instalar java SDK
sudo apt-get install default-jdk

# Setar java variável de ambiente
export JAVA_HOME="$(find /usr -type l -name 'default-java')"
if [ "$JAVA_HOME" != "" ]; then
    echo "export JAVA_HOME=$JAVA_HOME" >> ".bashrc"
fi

# Instalar ionic e cordova
npm install -g ionic cordova

cd "$INSTALL_PATH" && chmod 777 "node" -R
cd "$INSTALL_PATH" && chmod 777 "gradle" -R

# Limpar arquivos temporários
cd ~/ && rm "android-sdk.tgz"
cd ~/ && rm "nodejs.tgz"
cd ~/ && rm "gradle.zip"

echo "----------------------------------"
echo "Reinicie para completar a instação"
