function newImg = ImgProcess(image)
newImg = double(image);
newImg = MinMaxNormal(newImg);
newImg = AddRGBChannel(newImg);

end

