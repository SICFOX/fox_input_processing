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

ENDPOINT_URL = 'https://vision.googleapis.com/v1/images:annotate'

#[color, size]
arduino_input = [str(1), str(10)+'e']
#[size]
megapi_input = [str(10)]

cotton_size = 120
cotton_size_str = 0

arduino_control = ""
megapi_control = ""

# #Serial Port
# #Arduino
# ser = serial.Serial('/dev/cu.usbmodem14131', 9600)
# #MegaPi
# ser2 = serial.Serial('/dev/cu.wchusbserial14110', 9600)

def vision_api():
    image_filenames = ['./img/img1.jpg']
    img_requests = []

    for imgname in image_filenames:
        with open(imgname, 'rb') as f:
            ctxt = b64encode(f.read()).decode()
            img_requests.append({
                'image': {'content': ctxt},
                'features': [{
                    'type': 'FACE_DETECTION',
                    'maxResults': 5
                }]
            })
    response = requests.post(ENDPOINT_URL,
    data=json.dumps({"requests": img_requests}).encode(),
    params={'key': 'AIzaSyCYzlittDbDrELqOMGn77-LYLiuplMnvgA'},
    headers={'Content-Type': 'application/json'})

    if not image_filenames:
        print("Please specify API key and image file properly. $ python visionAPI.py image.jpg")
    else:
        if response.status_code != 200 or response.json().get('error'):
            print(response.text)
    if not response.json()['responses'][0]:
        arduino_input[0] = str(random.randint(0,3))
        #print(0)

    if response.json()['responses'][0]:
        a = response.json()['responses'][0]['faceAnnotations'][0]['joyLikelihood']
        b = response.json()['responses'][0]['faceAnnotations'][0]['sorrowLikelihood']
        c = response.json()['responses'][0]['faceAnnotations'][0]['angerLikelihood']
        d = response.json()['responses'][0]['faceAnnotations'][0]['surpriseLikelihood']
        emotion = {1:a, 2:b, 3:c, 0:d}
        emotion_text = {"喜び":a, "悲しみ":b, "怒り":c, "驚き":d}
        print(emotion_text)

        out = [key for key, value in emotion.items() if value == 'VERY_LIKELY']
        if not out:
            out2 = [key for key, value in emotion.items() if value == 'LIKELY']
            if not out2:
                out3 = [key for key, value in emotion.items() if value == 'POSSIBLE']
                if not out3:
                    arduino_input[0] = str(random.randint(0,3))
                    #print(0)
                else:
                    arduino_input[0] = str(out3[0])
            else:
                arduino_input[0] = str(out2[0])
        else:
                arduino_input[0] = str(out[0])
    #arduino_input[0] = str(1)

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


def send_to_arduino(arduino_control,megapi_control):
    print("シリアル通信するよ！")
    # sleep(5)
    # print(arduino_control)
    # ser.write(arduino_control)
    #
    # if cotton_size >= 0 and cotton_size <= 24:
    #     #small size
    #     sleep(10)
    # elif cotton_size > 24 and cotton_size <= 30:
    #     #midium size
    #     sleep(15)
    # else:
    #     #big size
    #     sleep(20)
    #
    # print(megapi_control)
    # ser2.write(megapi_control)
    # sleep(5)




if __name__ == '__main__':
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        # IP Adress and Port
        s.bind(('127.0.0.1', 5555))
    # 1 Connect
        s.listen(1)
    # Wait until Connection
        while True:
            conn, addr = s.accept()
            with conn:
                while True:
                    # Receive Data
                    data = conn.recv(1024)
                    if not data:
                        break
                    #print('data : {}, addr: {}'.format(data, addr))
                    if data == b"savefaceimage":
                        # from Processing receive ImageData
                        vision_api()
                        arduino_control = bytes(arduino_input[0] + ',' + arduino_input[1], 'utf-8')
                        megapi_control = bytes(megapi_input[0], 'utf-8')
                        print("APIから感情を分析しました")
                        print(arduino_control)
                        print(megapi_control)
                        #conn.sendall(b'1')
                        print(b'1')
                        #print(bytes(arduino_input[0]))
                        # conn.sendall(bytes(arduino_input[0],'utf-8'))
                        conn.send(arduino_input[0].encode('utf-8'))
                        #conn.sendall(b'3')

                    elif data == b"senddata":
                        # Arduinoにシリアル通信
                        send_to_arduino(arduino_control,megapi_control)
                        print("Arduinoにデータを送信しました")
                        print(arduino_control)
                        print(megapi_control)
                        conn.send("5".encode('utf-8'))

                    else:
                        # from Processing receive Cotton Candy Size
                        cotton_size_str = data.decode()  #Data input
                        # print(cotton_size_str)
                        cotton_size = int(cotton_size_str)
                        print(str(cotton_size) + "cm")

                        size_adjustment(cotton_size)

                        arduino_control = bytes(arduino_input[0] + ',' + arduino_input[1], 'utf-8')
                        megapi_control = bytes(megapi_input[0], 'utf-8')
                        print("わたあめの大きさを保存しました")
                        print(cotton_size_str + "cmです")
                        print(arduino_control)
                        print(megapi_control)

                        conn.send("4".encode('utf-8'))
