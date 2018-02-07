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
  'ʔ': '4/4d/Glottal_stop.ogg',
  // 'ts':
  // 'dz':
  // 't̠ʃ':
  'ʧ': '9/97/Voiceless_palato-alveolar_affricate.ogg',
  // 'd̠ʒ':
  // 'ʈʂ':
  // 'ɖʐ':
  // 't̠ɕ':
  'ʨ': 'c/c4/Voiceless_alveolo-palatal_affricate.ogg',
  // 'd̠ʑ':
  // 'pɸ':
  // 'bβ':
  // 'p̪f': TWO CHARS CURRENTLY UNSUPPORTED
  // 'b̪v':
  // 't̪θ':
  // 'd̪ð':
  // 'tɹ̝̊':
  // 'dɹ̝':
  // 't̠ɹ̠̊˔':
  // 'd̠ɹ̠˔':
  // 'cç':
  // 'ɟʝ':
  // 'kx':
  // 'ɡɣ':
  // 'qχ':
  // 'ʡħ':
  // 'ʔh':
  's': 'a/ac/Voiceless_alveolar_sibilant.ogg',
  'z': 'c/c0/Voiced_alveolar_sibilant.ogg',
  'ʃ': 'c/cc/Voiceless_palato-alveolar_sibilant.ogg',
  'ʒ': '3/30/Voiced_palato-alveolar_sibilant.ogg',
  'ʂ': 'b/b1/Voiceless_retroflex_sibilant.ogg',
  'ʐ': '7/7f/Voiced_retroflex_sibilant.ogg',
  'ɕ': '0/0b/Voiceless_alveolo-palatal_sibilant.ogg',
  'ʑ': '1/15/Voiced_alveolo-palatal_sibilant.ogg',
  'ɸ': '4/41/Voiceless_bilabial_fricative.ogg',
  'β': '1/11/Bilabial_approximant.ogg',
  'f': '3/33/Voiceless_labiodental_fricative.ogg',
  'v': '8/85/Voiced_labiodental_fricative.ogg',
  // 'θ̼': ,
  // 'ð̼': ,
  'θ': '8/80/Voiceless_dental_fricative.ogg',
  'ð': '6/6a/Voiced_dental_fricative.ogg',
  'θ̠': 'a/aa/Voiceless_alveolar_non-sibilant_fricative.ogg',
  'ð̠': '0/0a/Voiced_alveolar_non-sibilant_fricative.ogg',
  // 'ɹ̠̊˔' ,
  // 'ɹ̠˔' ,
  // 'ɻ˔' ,
  'ç': 'a/ab/Voiceless_palatal_fricative.ogg',
  'ʝ': 'a/ac/Voiced_palatal_fricative.ogg',
  'x': '0/0f/Voiceless_velar_fricative.ogg',
  'ɣ': '4/47/Voiced_velar_fricative.ogg',
  'χ': 'c/c8/Voiceless_uvular_fricative.ogg',
  'ʁ': 'a/af/Voiced_uvular_fricative.ogg',
  'ħ': 'b/b2/Voiceless_pharyngeal_fricative.ogg',
  'ʕ': 'c/cd/Voiced_pharyngeal_fricative.ogg',
  'ʢ': '8/83/Voiced_epiglottal_trill.ogg',
  'h': 'd/da/Voiceless_glottal_fricative.ogg',
  'ɦ': 'e/e2/Voiced_glottal_fricative.ogg',
  // 'ʋ̥':
  'ʋ': 'e/ee/Labiodental_approximant.ogg',
  // 'ɹ̥': ,
  'ɹ': '1/1f/Alveolar_approximant.ogg',
  // 'ɻ̊': ,
  'ɻ': 'd/d2/Retroflex_approximant.ogg',
  // 'j̊': ,
  'j': 'e/e8/Palatal_approximant.ogg',
  // 'ɰ̊': ,
  'ɰ': '5/5c/Voiced_velar_approximant.ogg',
  // 'ʔ̞': ,
  // 'ⱱ̟': ,
  'ⱱ': '2/2c/Labiodental_flap.ogg',
  // 'ɾ̼': ,
  // 'ɾ̥': ,
  'ɾ': 'a/a0/Alveolar_tap.ogg',
  // 'ɽ̊': ,
  'ɽ': '8/87/Retroflex_flap.ogg',
  // 'ɢ̆': '',
  'ʡ̮': 'f/f1/Epiglottal_flap.oga',
  // 'ʙ̥': ,
  'ʙ': 'e/e7/Bilabial_trill.ogg',
  // 'r̼': ,
  'r̥': '1/1e/Voiceless_alveolar_trill.ogg',
  'r': 'c/ce/Alveolar_trill.ogg',
  // 'ɽ̊ɽ̊': ,
  // 'ɽɽ': ,
  'ʀ̥': '8/8d/Voiceless_uvular_trill.ogg',
  'ʀ': 'c/cb/Uvular_trill.ogg',
  'ʜ': '7/7b/Voiceless_epiglottal_trill.ogg',
  'ʢ': '8/83/Voiced_epiglottal_trill.ogg',
  // 'tɬ':
  // 'dɮ':
  // 'ʈɭ̊˔':
  // 'cʎ̥˔':
  // 'kʟ̝̊':
  // 'ɡʟ̝':
  'ɬ': 'e/ea/Voiceless_alveolar_lateral_fricative.ogg',
  'ɮ': '6/6f/Voiced_alveolar_lateral_fricative.ogg',
  'ɭ̊˔': '5/54/Voiceless_retroflex_lateral_fricative.ogg',
  'ʎ̥˔': 'f/fe/Voiceless_palatal_lateral_fricative.ogg',
  // 'ʎ̝': ,
  'ʟ̝̊': '9/99/Voiceless_velar_lateral_fricative.ogg',
  'ʟ̝': '2/24/Voiced_velar_lateral_fricative.ogg',
  // 'l̥': ,
  'l': 'b/bc/Alveolar_lateral_approximant.ogg',
  // 'ɭ̊': ,
  'ɭ': 'd/d1/Retroflex_lateral_approximant.ogg',
  // 'ʎ̥': '',
  'ʎ': 'd/d9/Palatal_lateral_approximant.ogg',
  // 'ʟ̥': ,
  'ʟ': 'd/d3/Velar_lateral_approximant.ogg',
  'ʟ̠': '7/73/Uvular_lateral_approximant.ogg',
  'ɺ': 'd/df/Alveolar_lateral_flap.ogg',
  // 'ɺ̢': ,
  // 'ʎ̮': ,
  // 'ʟ̆': ,
  'w': 'f/f2/Voiced_labio-velar_approximant.ogg',
  'ɥ': 'f/fe/Labial-palatal_approximant.ogg',
  'ʍ': 'a/a7/Voiceless_labio-velar_fricative.ogg'
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
