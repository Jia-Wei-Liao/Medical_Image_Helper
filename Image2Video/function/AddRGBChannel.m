function [newImg] = AddRGBChannel(image)
newImg = repmat(image, 1, 1, 1, 3);

end