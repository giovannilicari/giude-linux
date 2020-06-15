#!/bin/bash
# Purpose: Set correct webserver files and dir permissions
# Per avviarlo: ./script /var/www/html/
# -------------------------------------------------------------------------------------------------
_dir="${1:-.}"
_fperm="0444"
_dperm="0445"
_ugperm="root:root"
_chmod="/bin/chmod"
_chown="/bin/chown"
_find="/usr/bin/find"
_xargs="/usr/bin/xargs"
 
echo "I will change the file permission for webserver dir and files to restrctive read-only mode for \"$_dir\""
read -p "Your current dir is ${PWD}. Are you sure (y / n) ?" ans
if [ "$ans" == "y" ]
then
	echo "Changing file onwership to $_ugperm for $_dir..."
	$_chown -R "${_ugperm}" "$_dir"
 
	echo "Setting $_fperm permission for $_dir directory...."
	$_chmod -R "${_fperm}" "$_dir"
 
	echo "Setting $_dperm permission for $_dir directory...."
	$_find "$_dir" -type d -print0 | $_xargs -0 -I {} $_chmod $_dperm {}
fi
