#!/bin/sh
working_dir="/tmp/mkpdf"

# get the name of the input file

if [ -z "$1" ]
then
    echo "!!! No file supplied! (Too few arguments)"
    exit 1
fi

full_name=$(readlink -f "$1")
filename=$(basename "$1")
name_no_extension=$(basename "$1" ".md")


# checking if all variables are set
if [ -z "$full_name" ] || [ -z "$filename" ] || [ -z "$name_no_extension" ]
then
    echo "!!! Something went wrong with the variable names!"
     exit 2
fi

# clean up and create the working dir
rm -rf "$working_dir" && mkdir -p "$working_dir"
cd "$working_dir"

# copy the file to the working dir
echo "-> Copying ${filename} to ${working_dir}..."
cp "$full_name" "$working_dir"

# check if the file exists!

working_copy="${working_dir}/${filename}"

if [ ! -f "$working_copy" ]
then
    echo "!!! Something went wrong while trying to copy the file into ${working_dir}!"
    exit 3
fi


# invoke pandoc to generate the pdf
echo "-> Invoking pandoc..."

generated_file="${working_dir}/${name_no_extension}.pdf"
pandoc "$working_copy" -o "${generated_file}"

# check if there now is our pdf file

if [ ! -f "$generated_file" ]
then
    echo "!!! Something went wrong in pandoc! Please see the output."
    exit 5
fi
# if there is, copy it back to the origin folder.

target_folder=$(dirname "$full_name")

echo "-> Copying file ${generated_file} back to where ${filename} came from..."
cp "$generated_file" "$target_folder"

# cleanup
echo "-> Cleaning up..."
rm -rf /tmp/mkpdf

echo "-> All done!" && exit 0
