# SPI to I2C Protocol Conversion using Verilog

## Introduction

This project was developed as part of Final Year Project for my B.Tech in Electronics and Telecommunications Engineering at [K. J. Somaiya College of Engineering, Mumbai](https://kjsce.somaiya.edu/en) during 2017 - 2018. This project was developed using [Xilinx ISE Design Suite 14.7](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html) and [ISim](https://www.xilinx.com/products/design-tools/isim.html) using [Verilog](https://en.wikipedia.org/wiki/Verilog).

Project Guide: [Prof. Ruchira A Jadhav](https://kjsce.somaiya.edu/en/view-member/160154?type=faculty)

Finally based on this project, a research paper was published in [IEEE](http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8697415&isnumber=8697217) on 25 April, 2019. This paper was presented in [2018 Fourth International Conference on Computing Communication Control and Automation (ICCUBEA)](https://ieeexplore.ieee.org/xpl/conhome/8681925/proceeding).

Co-Author: [Dvijen Trivedi](https://ieeexplore.ieee.org/author/37086820124), [Aniruddha Khade](https://ieeexplore.ieee.org/author/37086823074), [Kashish Jain](https://ieeexplore.ieee.org/author/37086515830), [Ruchira Jadhav](https://ieeexplore.ieee.org/author/37086456327)

**_Note:_** For ready reference, a pdf copy of the publised IEEE paper as mentioned above is attached here in the repository as [08697415.pdf](./08697415.pdf)

## Abstract

The purpose of this paper is to design and simulate a Protocol Conversion Unit (PCU) for seamless communication between the two widely accepted serial communication protocols SPI and I2C. Design given in this paper takes data from a sender device working on SPI protocol and sends it to a receiver device working on I2C protocol, which otherwise without such design would not be possible. SPI supports full duplex communication unlike I2C which is half duplex. Also SPI is faster than I2C. I2C on the other hand is just a two wire interface as unlike SPI it does not use a dedicated Slave Select line. Instead I2C relies on Address and Acknowledgement scheme to communicate with slave. Thus in areas where the controlling device needs to communicate with a lot of peripheral devices, it is essential for the controller to send commands and data to the concerned peripheral device quickly using high speed of SPI and at the same time save on dedicated pins for each peripheral device using a rather simple Two Wire Interface of I2C, a design capable of providing conversion between SPI and I2C formats becomes essential. In this paper support for just one peripheral device is given. The design in this paper can be upgraded to support large no of peripherals by providing a First In First Out (FIFO) Queue for storing commands and data along with corresponding addresses of peripheral devices in the Protocol Conversion Unit (PCU).

## Design and Test Code Files

5 Design files and 1 Test file, all coded in Verilog are provided here in the repository.

## References

1. Abhilash S.Warrier, Akshay S.Belvadi, Dhiraj R.Gawhane, Babu Ravi Teja K, FPGA Implementation Of SPI To I2C Bridge, International Journal of Engineering Research & Technology (IJERT), Vol. 2 Issue 11, November - 2013.
2. M. Morris Mano, Michael D. Ciletti, Digital Design:With an Introduction to verilog HDL, 5e, Pearson, 2013.