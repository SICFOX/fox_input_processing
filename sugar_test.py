#!/usr/bin/env python
# -*- coding: utf-8 -*-

#start python → processing
#close processing → python
#api_key AIzaSyCYzlittDbDrELqOMGn77-LYLiuplMnvgA

import socket
from base64 import b64encode
import json
import requests
import serial
from time import sleep
import random


#[color, size]
arduino_input = [str(2), str(10)+'e']
#[size]
megapi_input = [str(2)]

cotton_size = 120
cotton_size_str = 0

arduino_control = ""
megapi_control = ""

# Serial Port
#Arduino
ser = serial.Serial('/dev/cu.usbmodem14121', 9600)
#MegaPi
ser2 = serial.Serial('/dev/cu.wchusbserial14140', 9600)


def size_adjustment(cotton_size):
    #Arduino
    if cotton_size >= 0 and cotton_size <= 17:
        arduino_input[1] = str('3') + 'e'
    elif cotton_size > 17 and cotton_size <= 24:
        arduino_input[1] = str('6') + 'e'
    elif cotton_size > 24 and cotton_size <= 30:
        arduino_input[1] = str('14') + 'e'
    elif cotton_size > 30 and cotton_size <= 37:
        arduino_input[1] = str('20') + 'e'
    else:
        arduino_input[1] = str('25') + 'e'

    # MegaPi
    if cotton_size >= 0 and cotton_size <= 24:
        megapi_input[0] = str('1')
    elif cotton_size > 24 and cotton_size <= 30:
        megapi_input[0] = str('2')
    elif cotton_size > 30 and cotton_size <= 37:
        megapi_input[0] = str('3')
    else:
        megapi_input[0] = str('4')


def send_to_arduino(arduino_control):
    print("シリアル通信するよ！")
    sleep(5)
    print(arduino_control)
    ser.write(arduino_control)
    print("SleepNow")
    if cotton_size >= 0 and cotton_size <= 24:
        #small size
       sleep(10)
    elif cotton_size > 24 and cotton_size <= 30:
        #midium size
       sleep(15)
    else:
        #big size
       sleep(20)
    print("Wakeup")
    sleep(3)


#    delay_time = ser.read(3)
# #    if not delay_time:
#        delay_time = ser.read(3)
#    else:
#        print(megapi_control)
#        ser2.write(megapi_control)
#    sleep(5)

def send_to_megapi(megapi_control):
    #sleep(5)
    print("megapi")
    delay_time = ser.readline()
    print(delay_time)
    if not delay_time:
        delay_time = ser.readline()
    else:
        #sleep(5)
        print(megapi_control)
        ser2.write(megapi_control)
    sleep(5)


if __name__ == '__main__':
    arduino_control = bytes(arduino_control, 'utf-8')
    megapi_control = bytes(megapi_control, 'utf-8')
    send_to_arduino(arduino_control)
    print("Arduinoにデータを送信しました")
    print(arduino_control)
    #print("SleepNow")
    #sleep(20)
    #print("Wakeup")
    send_to_megapi(megapi_control)
    print("Megapiにデータを送信しました")
    print(megapi_control)
