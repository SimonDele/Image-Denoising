## Takes in a 2D greyscale (in [0,255]) image and stripes it,
## with a given stripe probability.
## Author: Naoshikuu <louis@computy>
## Created: 2018-03-12

function [imfinal] = stripify (imorigin, probaStripe)
  imfinal = imorigin;
  [nrow, ncol] = size(imorigin);
  ## The striped columns
  striped = (rand(ncol,1) < probaStripe).*rand(ncol,1)*255;
  for i = 1:ncol
    if striped(i)>0
      imfinal(:,i) = striped(i);
    endif
  endfor
endfunction
