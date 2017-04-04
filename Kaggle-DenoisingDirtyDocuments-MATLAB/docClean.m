function composite = doClean(pngFile)
    idoc=iread(pngFile);
    ddoc=iread(pngFile,'double');
    docBG=iclean(idoc);
    clean=docBG-idoc;
    level = graythresh(clean);
    bwdoc=im2bw(clean,level*0.75);
    distDoc=graydist((1-ddoc),~bwdoc);
    isText=distDoc>.01;
    mask=uint8(isText);
    notmask=uint8(~mask);
    backdrop=uint8(ones(size(notmask))*255);
    composite = mask.* idoc +notmask.* backdrop ;
    composite(composite>160)=255;
end