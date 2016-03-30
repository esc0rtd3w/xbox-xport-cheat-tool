#!/bin/sh


# XBOX1 X-Port Emulator Cheat Tool

# Version 0.2 Pre-Alpha

# esc0rtd3w / ins3cure.com





# -------------------------------------------------------------------
# VARIABLES

DIRNAME=`echo ${PWD##*/}`

CHEATFILE=`find *.cht`

OFFSET=''

VALUE=''


# Cheat Code Specifics

# PADDING refers to "00"

LENGTH_CHUNK1_CODE_TEXT=8
LENGTH_CHUNK2_PADDING=1
LENGTH_CHUNK3_CODE_TEXT_VALUE=4
LENGTH_CHUNK4_PADDING=1
LENGTH_CHUNK5_GARBAGE=6
LENGTH_CHUNK6_CODE_HEX=6
LENGTH_CHUNK7_PADDING=1
LENGTH_CHUNK8_CODE_VALUE=2
LENGTH_CHUNK9_PADDING=4
LENGTH_CHUNK10_CODE_DESCRIPTION=99
LENGTH_CHUNK11_GARBAGE=4


DATA_CHUNK1_CODE_TEXT=30000000
DATA_CHUNK2_PADDING=00
DATA_CHUNK3_CODE_TEXT_VALUE=0000
DATA_CHUNK4_PADDING=00
DATA_CHUNK5_GARBAGE=AAAAAA
DATA_CHUNK6_CODE_HEX=30000000
DATA_CHUNK7_PADDING=00
DATA_CHUNK8_CODE_VALUE=0000
DATA_CHUNK9_PADDING=00000000
DATA_CHUNK10_CODE_DESCRIPTION="Some 99 character description can be inserted here firmly"
DATA_CHUNK11_GARBAGE=00000000



# Location Specifics

currentByte=0
 
lastByte=0
 
bytesInCurrentChunk=0
 
numberOfCheatsLeft=0
 
currentCheatNumber=0
 
nextCheatNumber=0
 
lastCheatNumber=0


# -------------------------------------------------------------------


# -------------------------------------------------------------------
# FUNCTIONS


getFileDetails()
{

    cheatFileSize=$(stat -c%s "$CHEATFILE")
    
    numberOfCheats=$(($cheatFileSize / 136))
    
}


replaceBytes()
{
    # Outputs \x$VALUE (e.g. \xFF)
    #printf "$(printf '\\x%02X' $3)" | dd of="$1" bs=1 seek=$2 count=1 conv=notrunc &> /dev/null
    
    
    # Working Method
    #printf \xff | dd conv=notrunc of="$CHEATFILE" bs=1 seek=$((0x00000004))
    
    
    #printf "0x%x\n" 1024

    #printf '%d\n' 0x$3

    
    
    printf "%02x" 0x$3 | dd conv=notrunc of="$1" bs=1 seek=$((0x$2))
    
}


extractBytes()
{

    # Make sure "tmp" directory exists
    fixTemp
    
    
    # Refresh current file details
    getFileDetails
    
    

    
    
    head -c $currentOffset "$CHEATFILE" > tmp/index-$currentOffset
    
    #head -c 136 "$CHEATFILE" > tmp/index-00000000

    #printf "%02x" "$CHEATFILE" | dd conv=notrunc of="index-00000000" bs=1 seek=0x00000000
    

 
    
}



showFolders()
{

find $1 -maxdepth 1 -type d

}



fixTemp()
{

    checkTemp=$(ls | grep tmp)

    if [ "$checkTemp" != "tmp" ]; then
    
      mkdir tmp
    
    fi
    
 }
 
 
 
 
 breakApartCheatFile()
 {
 
 # Need to do the following
 
 # 1. Take total cheats, and starting at 0, increment by 136 bytes everytime a "head -c" is performed
 
 # 2. Save each 136 byte chunk into a separate temp file or variable
 
 # 3. Now pieces can be re-assembled, re-sorted, and saved into a new file
 
 # 4. Also be able to create new valid files from scratch
 
 echo
 echo Checking Cheat File....
 echo
 

   byteLoop()
   {
     
   
   if [ $numberOfCheatsLeft -ne 0 ]; then
   
     
     echo
     echo
     echo "----------------------------------"
     echo " XBOX1 X-Port Emulator Cheat Tool"
     echo "----------------------------------"
     echo "     esc0rtd3w / ins3cure.com"
     echo "----------------------------------"
     echo
     echo "----------------------------------"
     echo "      Cheat File Information"
     echo "----------------------------------"
     echo
     echo
     echo
     echo Current Byte: $currentByte
     echo
     echo Last Byte: $lastByte
     echo
     echo Bytes In Current Chunk: $bytesInCurrentChunk
     echo
     echo Cheats Left: $numberOfCheatsLeft
     echo
     echo Current Cheat Number: $currentCheatNumber
     echo
     echo Last Cheat Number: $lastCheatNumber
     echo
     echo Next Cheat Number: $nextCheatNumber
     echo
     echo

     read -p "" dummy;
     
     head -c $currentByte "$CHEATFILE" > tmp/$currentByte.bin
    
    
     byteLoop
     
     else
     
      echo
      echo
      echo Loop Finished!
      echo
      echo
      
      read -p "" dummy;
      
      fi
   
    }
    

  fixTemp
 
  getFileDetails
 
  byteLoop

 
   #head -c $currentCodeChunk "$CHEATFILE" > tmp/code.bin
   
 
 }
 
 



# -------------------------------------------------------------------


menu_main()
{


echo
echo
echo "----------------------------------"
echo " XBOX1 X-Port Emulator Cheat Tool"
echo "----------------------------------"
echo "     esc0rtd3w / ins3cure.com"
echo "----------------------------------"
echo
echo "----------------------------------"
echo "       General Information"
echo "----------------------------------"
echo
echo
echo
echo "Current Directory Name: $DIRNAME"
echo
echo "Current Cheat File: $CHEATFILE"
echo
echo
echo "Cheat File Size:" $cheatFileSize "bytes"
echo
echo "Number of Cheats in File:" $numberOfCheats
echo
echo "Current Cheat Number:" $getCheatsLeft
echo "Current Offset:" $currentOffset
echo
echo


echo
echo "Press any key to continue..."
echo
echo

read -p "" dummy

breakApartCheatFile

}




#getFileDetails

menu_main




#extractBytes







#replaceByte "$CHEATFILE" 00000000 FF















