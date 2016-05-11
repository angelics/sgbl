#!/bin/sh

mkdir -p /tmp/angpfsense
rm -rf /tmp/angpfsense/*
cd /tmp/angpfsense

# shallalist
# download
fetch [shallalist]

# extract
tar -zxvf shallalist.tar.gz

# ATS
# create ATS folder
mkdir -p BL/ATS

# download
fetch [hp-hosts_ats]

# remove line
cat ad_servers.txt | sed '/localhost/d' > BL/ATS/domains
cat BL/ATS/domains | sed '/^#/d' > BL/ATS/domains.temp

# format
cat BL/ATS/domains.temp | sed -r 's/127.0.0.1	//' > BL/ATS/domains

# remove temp
rm BL/ATS/domains.temp

# EMD
# create EMD folder
mkdir -p BL/EMD

# download
fetch http://hosts-file.net/emd.txt

# remove line
cat emd.txt | sed '/localhost/d' > BL/EMD/domains
cat BL/EMD/domains | sed '/^#/d' > BL/EMD/domains.temp

# format
cat BL/EMD/domains.temp | sed -r 's/127.0.0.1	//' > BL/EMD/domains

# remove temp
rm BL/EMD/domains.temp

# FSA
# create FSA folder
mkdir -p BL/FSA

# download
fetch [hp-hosts-fsa]

# remove line
cat fsa.txt | sed '/localhost/d' > BL/FSA/domains
cat BL/FSA/domains | sed '/^#/d' > BL/FSA/domains.temp

# format
cat BL/FSA/domains.temp | sed -r 's/127.0.0.1	//' > BL/FSA/domains

# remove temp
rm BL/FSA/domains.temp

# EXP
# create EXP folder
mkdir -p BL/EXP

# download
fetch [hp-hosts_exp]

# remove line
cat exp.txt | sed '/localhost/d' > BL/EXP/domains
cat BL/EXP/domains | sed '/^#/d' > BL/EXP/domains.temp

# format
cat BL/EXP/domains.temp | sed -r 's/127.0.0.1	//' > BL/EXP/domains

# remove temp
rm BL/EXP/domains.temp

# PSH
# create PSH folder
mkdir -p BL/PSH

# download
fetch [hp-hosts-psh]

# remove line
cat psh.txt | sed '/localhost/d' > BL/PSH/domains
cat BL/PSH/domains | sed '/^#/d' > BL/PSH/domains.temp

# format
cat BL/PSH/domains.temp | sed -r 's/127.0.0.1	//' > BL/PSH/domains

# remove temp
rm BL/PSH/domains.temp

# mdl
# create mdl folder
mkdir -p BL/mdl

# download
fetch [malwaredomainlist]

# remove line
cat hosts.txt | sed '/localhost/d' > BL/mdl/domains
cat BL/mdl/domains | sed '/^#/d' > BL/mdl/domains.temp

# format
cat BL/mdl/domains.temp | sed -r 's/127.0.0.1  //' > BL/mdl/domains

# remove temp
rm BL/mdl/domains.temp

# DNSBH
# create DNSBH folder
mkdir -p BL/DNSBH

# download
fetch [dnsbh]
cat justdomains > BL/DNSBH/domains

# openphish
# create OPNPSH folder
mkdir -p BL/OPNPSH

# download
fetch [openphish]

# format
cat feed.txt | sed -r 's/http:\/\///' > BL/OPNPSH/urls

# phishtank
# create PSHTNK folder
mkdir -p BL/PSHTNK

# download
fetch [phishtank]

# extract
bunzip2 online-valid.csv.bz2

# remove line
cat online-valid.csv | sed 's/^[0-9]*,//' > BL/PSHTNK/urls
cat BL/PSHTNK/urls | sed 's@,http://www.phishtank.com/phish_detail.php?phish_id=[0-9]*,.*$@@' > BL/PSHTNK/urls.temp
cat BL/PSHTNK/urls.temp | sed 's/^"\(.*\)"$/\1/' > BL/PSHTNK/urls
cat BL/PSHTNK/urls | sed '/phish_id/d' > BL/PSHTNK/urls.temp

# format
cat BL/PSHTNK/urls.temp | sed -r 's/http:\/\///' > BL/PSHTNK/urls
cat BL/PSHTNK/urls | sed -r 's/https:\/\///' > BL/PSHTNK/urls.temp
cat BL/PSHTNK/urls.temp > BL/PSHTNK/urls

# remove temp
rm BL/PSHTNK/urls.temp

# angelics - gamble
# create ang_gamble folder
mkdir -p BL/ang_gamble

# download
fetch [github_ang-gamble]

# copy to folder
cp domains BL/ang_gamble

# create package
tar -caf angpfsense.tar.gz BL

# copy to destination
cp angpfsense.tar.gz /tmp

/tmp/squidGuard_blacklist_update.sh
