#!/bin/bash

croat_unit=100000000000
walletd_port=46349
interval=5
duration=120
anonymity=1
optimize_value=10000

echo ""
echo ""
echo " ██████╗██████╗  ██████╗  █████╗ ████████╗"
echo "██╔════╝██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝"
echo "██║     ██████╔╝██║   ██║███████║   ██║   "
echo "██║     ██╔══██╗██║   ██║██╔══██║   ██║   "
echo "╚██████╗██║  ██║╚██████╔╝██║  ██║   ██║   "
echo " ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   "
echo "     .-=[CROAT WALLETD OPTIMIZER]=-.      "
echo ""
echo ""

PS3="Select the option: "
options=("Preview Optimization" "Optimize Wallet" "Exit")

select option in "${options[@]}"; do
    case $option in
        "Preview Optimization")    
            echo ""
            echo "######### WALLET PREVIEW OPTIMIZATON #########"
            echo ""
            read -p "Please, specify CROAT walletd RPC Port (Default: $walletd_port): " -e -i $walletd_port walletd_port
            read -p "Please, specify optimization value: (Default: $optimize_value CROAT): " -e -i $optimize_value optimize_value
            final_value=$((optimize_value * croat_unit))
            echo "The wallet will be optimized for: ${final_value} (${optimize_value}) CROAT"
           ./optimizer --walletd-port=$walletd_port --interval $interval --duration $duration --threshold $final_value --anonymity $anonymity --preview
            break
            ;;
        "Optimize Wallet") 
            echo ""
            echo "######### WALLET OPTIMIZATON #########"
            echo ""
            read -p "Please, specify CROAT walletd RPC Port (Default: $walletd_port): " -e -i $walletd_port walletd_port
            read -p "Please, specify interval between fusion transactions (Default $interval): " -e -i $interval interval
            read -p "Please, specify max optimization duration (Default $duration): " -e -i $duration duration
            read -p "Please, specify transactions anonymity (Default: $anonymity): " -e -i $anonymity anonymity
            read -p "Please, specify optimization amount: (Default: $optimize_value CROAT): " -e -i $optimize_value optimize_value
            final_value=$((optimize_value * croat_unit))
            echo ""
            echo "The wallet will be optimized for: ${optimize_value} CROAT => (${final_value})"
            echo ""
                echo "This will run walletd optimization for all optimizable wallets, and repeat operation after 60 seconds!"
                echo "To end optimization, press Ctrl+C!"
                echo ""
                read -p "Do you wish to continue? [Y]es or [N]ot? " yn
                case $yn in
                [Yy]* )
                while true; do
                    ./optimizer --walletd-port=$walletd_port --interval $interval --duration $duration --threshold $final_value --anonymity $anonymity
                    echo "Optimization round successfull!!"
                    echo "To end optimization, press Ctrl+C!"
                    for i in {60..1};do echo -ne "Waiting $i seconds for next optimization round!\r" && sleep 1; done
                done
                ;;
                [Nn]* ) 
                exit
                ;;
                * ) echo "Please answer [Y]es or [N]o! "
                ;;
                esac
            break
            ;;
        "Exit")
            exit
            ;;
        *) echo "Invalid Option $REPLY";;
    esac
done
