var HOST = 'https://upload.wikimedia.org/wikipedia/commons/';

var files = {
  'i': '9/91/Close_front_unrounded_vowel.ogg',
  'y': 'e/ea/Close_front_rounded_vowel.ogg',
  'ɨ': '5/53/Close_central_unrounded_vowel.ogg',
  'ʉ': '6/66/Close_central_rounded_vowel.ogg',
  'ɯ': 'e/e8/Close_back_unrounded_vowel.ogg',
  'u': '5/5d/Close_back_rounded_vowel.ogg',
  'ɪ': '4/4c/Near-close_near-front_unrounded_vowel.ogg',
  'ʏ': 'e/e3/Near-close_near-front_rounded_vowel.ogg',
  'ɪ̈': 'f/fe/Near-close_central_unrounded_vowel.ogg',
  // 'ʊ̈': ,
  'ɯ̽': 'c/cc/Near-close_near-back_unrounded_vowel.ogg',
  'ʊ': 'd/d5/Near-close_near-back_rounded_vowel.ogg',
  'e': '6/6c/Close-mid_front_unrounded_vowel.ogg',
  'ø': '5/53/Close-mid_front_rounded_vowel.ogg',
  'ɘ': '6/60/Close-mid_central_unrounded_vowel.ogg',
  'ɵ': 'b/b5/Close-mid_central_rounded_vowel.ogg',
  'ɤ': '2/26/Close-mid_back_unrounded_vowel.ogg',
  'o': '8/84/Close-mid_back_rounded_vowel.ogg',
  'e̞': 'e/e0/Mid_front_unrounded_vowel.ogg',
  // 'ø̞': ,
  'ə': 'd/d9/Mid-central_vowel.ogg',
  'ɵ̞': 'c/cd/Mid_central_rounded_vowel.ogg',
  // 'ɤ̞': ,
  'o̞': 'a/a6/Mid_back_rounded_vowel.ogg',
  'ɛ': '7/71/Open-mid_front_unrounded_vowel.ogg',
  'œ': '0/00/Open-mid_front_rounded_vowel.ogg',
  'ɜ': '0/01/Open-mid_central_unrounded_vowel.ogg',
  'ɞ': 'd/d9/Open-mid_central_rounded_vowel.ogg',
  'ʌ': '9/92/Open-mid_back_unrounded_vowel.ogg',
  'ɔ': '0/02/Open-mid_back_rounded_vowel.ogg',
  'æ': 'c/c9/Near-open_front_unrounded_vowel.ogg',
  'ɐ': '2/22/Near-open_central_unrounded_vowel.ogg',
  // 'ɞ̞': ,
  'a': '6/65/Open_front_unrounded_vowel.ogg',
  'ɶ': 'c/c1/Open_front_rounded_vowel.ogg',
  'ä': '5/50/Open_central_unrounded_vowel.ogg',
  'ɒ̈': 'f/f2/Open_central_rounded_vowel.ogg',
  'ɑ': 'e/e5/Open_back_unrounded_vowel.ogg',
  'ɒ': '0/0a/Open_back_rounded_vowel.ogg',
  // 'm̥':,
  'm': 'a/a9/Bilabial_nasal.ogg',
 	'ɱ': '1/18/Labiodental_nasal.ogg',
  'n̼': '8/82/Linguolabial_nasal.ogg',
  // 'n̥': ,
  'n': '2/29/Alveolar_nasal.ogg',
  // 'ɳ̊': ,
  'ɳ': 'a/af/Retroflex_nasal.ogg',
  // 'ɲ̊': ,
  'ɲ': '4/46/Palatal_nasal.ogg',
  // 'ŋ̊': ,
  'ŋ': '3/39/Velar_nasal.ogg',
  'ɴ': '3/3e/Uvular_nasal.ogg',
  'p': '5/51/Voiceless_bilabial_plosive.ogg',
  'b': '2/2c/Voiced_bilabial_plosive.ogg',
  // 'p̪': ,
  // 'b̪': ,
  // 't̼': ,
  // 'd̼': ,
  't': '0/02/Voiceless_alveolar_plosive.ogg',
  'd': '0/01/Voiced_alveolar_plosive.ogg',
  'ʈ': 'b/b0/Voiceless_retroflex_stop.oga',
  'ɖ': '2/27/Voiced_retroflex_stop.oga',
  'c': '5/5d/Voiceless_palatal_plosive.ogg',
  'ɟ': '1/1d/Voiced_palatal_plosive.ogg',
  'k': 'e/e3/Voiceless_velar_plosive.ogg',
  'ɡ': '1/12/Voiced_velar_plosive_02.ogg',
  'q': '1/19/Voiceless_uvular_plosive.ogg',
  'ɢ': 'b/b6/Voiced_uvular_stop.oga',
  'ʡ': 'b/b2/Epiglottal_stop.ogg',
  'ʔ': '4/4d/Glottal_stop.ogg'
}

var sounds = {}

function retrieveSounds(chars) {
  for (var i = 0; i < chars.length; i++) {
    if (sounds[chars[i]] == null && files[chars[i]] != null) {
      sounds[chars[i]] = new Audio(HOST + files[chars[i]]);
    }
  }
}

function playSound() {
  var char = $(this).text();
  if (soundPresent(char)) {
    var snd = sounds[char];
    snd.play();
    snd.currentTime=0;
  }
}

function soundPresent(char) {
  return sounds[char] != null;
}
