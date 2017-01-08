#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

install(){
  rm -rf tg && git clone --recursive "https://github.com/Enigma-Team/tg.git"
  patch -i "patches/disable-python-and-libjansson.patch" -p 0 --batch --forward
  RET=$?;
  cd tg
    if [ $RET -ne 0 ]; then
        autoconf -i
      fi
    ./configure && make
    RET=$?; if [ $RET -ne 0 ]; then
      echo "Error. Exiting."; exit $RET;
    fi
    cd ..
    chmod +x auto.sh
    sed -i 's/\r$//' auto.sh
    echo ""
    echo -e "\033[01;32m    Installing Done!\033[0m,\n \033[01;34m Now you Can run your bot! \033[0m"
    echo "    >> Launch in Normal Mode : ./run.sh"
    echo "    >> Launch in Screen Mode : screen ./run.sh"
    echo "    >> Launch with AutoLaunch : screen ./auto.sh"
    echo -e "       \033[01;30mPowered By Enigma (@EnigmaTM)\033[0m\n"
}

if [ "$1" = "install" ]; then
  install
else
  if [ ! -f ./tg/telegram.h ]; then
      echo "Telegram-Cli(tg) Not Found !"
      echo "Run $0 install"
      exit 1
    fi
    if [ ! -f ./tg/bin/telegram-cli ]; then
        echo "Telegram-Cli(tg) Not Found !"
        echo "Run $0 install"
        exit 1
      fi
      rm -r ../.telegram-cli/state # Prevents Tg Form Crashing !
      ./tg/bin/telegram-cli -k ./tg/tg-server.pub -s ./bot/bot.lua -l 1 -E $@
fi
