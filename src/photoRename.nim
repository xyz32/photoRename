#? braces
import os, times, ospaths, strutils;

proc getName(oldName: string, imgTime: TimeInfo): string {
  let picDay = parseInt(format(imgTime, "dd"));
  let picMonth = parseInt(format(imgTime, "MM"));
  
  result = oldName;
  
  if (picMonth == 11) {
    if (picDay == 30) {result = "Mexico";}
    if (picDay == 29) {result = "Texas";}
    if (picDay == 28) {result = "Space Center Houston";}
    if (picDay == 26 or picDay == 27) {result = "On the road to New Orleans";}
  } 
  if (picMonth == 12) {
    if (picDay == 23) {result = "Washington";}
    if (picDay == 21 or picDay == 22) {result = "Memphis & Nashville TN";}
    if (picDay == 18 or picDay == 19) {result = "North of Mexico";}
    if (picDay == 16 or picDay == 17) {result = "Pico de Orizaba";}
    if (picDay == 15) {result = "Golf of Mexico";}
    if (picDay == 14) {result = "Uxmal, Chocolate Museum & Golf of Mexic";}
    if (picDay == 13) {result = "Cancun & Chichen Itza";}
    if (picDay == 12) {result = "Tulum, Cenote & Playa del Carmen";}
    if (picDay == 11) {result = "Tulum & Grand Cenote";}
    if (picDay == 10) {result = "Becan, Chetumal & Mahahual";}
    if (picDay == 9) {result = "Palenque";}
    if (picDay == 8) {result = "Tonina to Villahermosa via San Cristobal";}
    if (picDay == 7) {result = "San Cristobal & Tonina";}
    if (picDay == 6) {result = "Tuxtla Guttierez & San Cristobal de las Casas";}
    if (picDay == 5) {result = "Pacific Coast";}
    if (picDay == 4) {result = "Acapulco";}
    if (picDay == 3) {result = "Cacahuamilpa Caves";}
    if (picDay == 2) {result = "Mexico City";}
    if (picDay == 1) {result = "Teotihuacan";}
  }
}

proc echoFiles(useName, path, output: string) {
  for file in walkFiles(path) {
    echo file;
    let [dir, name, ext] = splitFile(file);
    var editTime: TimeInfo;
    if (useName == "1") {
      editTime = parse(name, "yyyy-MM-dd'_'HH-mm'.'ss");
    } else {
      editTime = getLocalTime(getLastModificationTime(file));
    }
    
    let edYear = parseInt(format(editTime, "yyyy"));
    let edDay = parseInt(format(editTime, "dd"));
    
    if (edYear == 2013) {
      editTime = editTime + 3.years + 7.months + 13.days + 10.hours + 38.minutes;
    }
    
    var newName = format(editTime, "yyyy-MM-dd'_'HH-mm'.'ss");
    let imgName = getName(name,editTime);
    if (imgName == name) {
      discard existsOrCreateDir(output & "/misc");
      newName = output & "/misc/" & newName & " " & imgName & ext;
    } else {
      let folderName = format(editTime, "yyyy-MM-dd") & " " & imgName;
      discard existsOrCreateDir(output & "/" & folderName);
      newName = output & "/" & folderName & "/" & newName & " " & imgName & ext;
    }
    echo newName;
  
    #copyFile(file, newName);
    moveFile(file, newName);
  }
}

when (isMainModule){
  let programName = getAppFilename()
  let arguments = commandLineParams()
  
  echoFiles(arguments[0], arguments[1], arguments[2]);
}
