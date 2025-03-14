export interface StopPosition {
  x: number;
  y: number;
  color: string;
}

// RGB转十六进制
export function rgbToHex(r: number, g: number, b: number): string {
  // 确保值在0-255范围内
  r = Math.max(0, Math.min(255, r));
  g = Math.max(0, Math.min(255, g));
  b = Math.max(0, Math.min(255, b));

  // 转换为16进制并确保每个颜色通道都是两位数
  return '#' + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
}

export function hexToRgb(hex: string): [number, number, number] {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  if (!result) {
    throw new Error('Invalid HEX color');
  }
  return [parseInt(result[1], 16), parseInt(result[2], 16), parseInt(result[3], 16)];
}

function transferConfig(data: Record<string, { color: string; com: string }>) {
  const config = Object.keys(data).reduce((acc, key) => {
    if (data[key].com) {
      const color = data[key].color.split(',').map(Number);
      const hex = rgbToHex(color[0], color[1], color[2]);
      acc[hex] = data[key].com;
    }
    return acc;
  }, {} as Record<string, string>);
  return config;
}

/** 佳佳一键宏 */
export const color_mappings_JIAJIA: Record<string, string> = {
  '#8cd6ee': 'ALT-CTRL-F1',
  '#8ca3ee': 'ALT-CTRL-F2',
  '#9b8cee': 'ALT-CTRL-F3',
  '#bd8ded': 'ALT-CTRL-F4',
  '#e48cee': 'ALT-CTRL-F5',
  '#ee8cdb': 'ALT-CTRL-F6',
  '#ef8fbd': 'ALT-CTRL-F7',
  '#ef8f92': 'ALT-CTRL-F8',
  '#e673c4': 'ALT-CTRL-F9',
  '#9571e8': 'ALT-CTRL-F10',
  '#e7ae18': 'ALT-CTRL-F11',
  '#e19257': 'ALT-CTRL-F12',
  '#f5f9b7': 'ALT-CTRL-SHIFT-F1',
  '#f9ddb7': 'ALT-CTRL-SHIFT-F2',
  '#f7c2ae': 'ALT-CTRL-SHIFT-F3',
  '#f7aeae': 'ALT-CTRL-SHIFT-F4',
  '#eda08d': 'ALT-CTRL-SHIFT-F5',
  '#edb98d': 'ALT-CTRL-SHIFT-F6',
  '#edda8d': 'ALT-CTRL-SHIFT-F7',
  '#d2ed8d': 'ALT-CTRL-SHIFT-F8',
  '#a6ed8d': 'ALT-CTRL-SHIFT-F9',
  '#8dedce': 'ALT-CTRL-SHIFT-F10',
  '#31e4f9': 'ALT-CTRL-SHIFT-F11',
  '#8a88d0': 'ALT-CTRL-SHIFT-F12',
  '#aee6ae': 'ALT-NUM0',
  '#bd4043': 'ALT-NUM1',
  '#dc96c7': 'ALT-NUM2',
  '#b54ac4': 'ALT-NUM3',
  '#bd9bdf': 'ALT-NUM4',
  '#5444c4': 'ALT-NUM5',
  '#9eb7e0': 'ALT-NUM6',
  '#57b4c8': 'ALT-NUM7',
  '#97ddcf': 'ALT-NUM8',
  '#4fc882': 'ALT-NUM9',
  '#f8b4b6': 'ALT-SHIFT-F1',
  '#f9b3db': 'ALT-SHIFT-F2',
  '#fab1f4': 'ALT-SHIFT-F3',
  '#e2b3f9': 'ALT-SHIFT-F4',
  '#cbb1fa': 'ALT-SHIFT-F5',
  '#b0b3fb': 'ALT-SHIFT-F6',
  '#b0d2fb': 'ALT-SHIFT-F7',
  '#b3ecf9': 'ALT-SHIFT-F8',
  '#b7f9d8': 'ALT-SHIFT-F9',
  '#b7f9c2': 'ALT-SHIFT-F10',
  '#56b3da': 'ALT-SHIFT-F11',
  '#a669c7': 'ALT-SHIFT-F12',
  '#f78a48': 'ALT-CTRL-NUM0',
  '#f9e746': 'ALT-CTRL-NUM1',
  '#bffa45': 'ALT-CTRL-NUM2',
  '#6dfa45': 'ALT-CTRL-NUM3',
  '#44fbbf': 'ALT-CTRL-NUM4',
  '#44c4fb': 'ALT-CTRL-NUM5',
  '#4476fb': 'ALT-CTRL-NUM6',
  '#9644fb': 'ALT-CTRL-NUM7',
  '#f744fb': 'ALT-CTRL-NUM8',
  '#fb4496': 'ALT-CTRL-NUM9',
  '#59a323': 'CTRL-F1',
  '#35483c': 'CTRL-F2',
  '#b89eb8': 'CTRL-F3',
  '#b19eb8': 'CTRL-F4',
  '#ab9eb8': 'CTRL-F5',
  '#a59eb8': 'CTRL-F6',
  '#9e9eb8': 'CTRL-F7',
  '#9eb8b8': 'CTRL-F8',
  '#b89eb1': 'CTRL-F9',
  '#9eb1b8': 'CTRL-F10',
  '#9eb89e': 'CTRL-F11',
  '#b8b89e': 'CTRL-F12',
  '#e66f68': 'CTRL-NUM0',
  '#e7aa67': 'CTRL-NUM1',
  '#e8d166': 'CTRL-NUM2',
  '#dce965': 'CTRL-NUM3',
  '#9de965': 'CTRL-NUM4',
  '#22cc1e': 'CTRL-NUM5',
  '#40e3aa': 'CTRL-NUM6',
  '#40cbe3': 'CTRL-NUM7',
  '#3f75e4': 'CTRL-NUM8',
  '#743ee6': 'CTRL-NUM9',
  '#f154da': 'CTRL-SHIFT-F1',
  '#e0a3f8': 'CTRL-SHIFT-F2',
  '#8d56f3': 'CTRL-SHIFT-F3',
  '#9c9cf8': 'CTRL-SHIFT-F4',
  '#60a3f4': 'CTRL-SHIFT-F5',
  '#b4f8fa': 'CTRL-SHIFT-F6',
  '#6cf4aa': 'CTRL-SHIFT-F7',
  '#c6fab4': 'CTRL-SHIFT-F8',
  '#d7f777': 'CTRL-SHIFT-F9',
  '#fac2da': 'CTRL-SHIFT-F10',
  '#a56fbf': 'CTRL-SHIFT-F11',
  '#83a34e': 'CTRL-SHIFT-F12',
  '#ecb182': 'CTRL-SHIFT-B',
  '#a6f4f2': 'CTRL-SHIFT-C',
  '#a6f4c1': 'CTRL-SHIFT-F',
  '#f4cfa6': 'CTRL-SHIFT-G',
  '#ece782': 'CTRL-SHIFT-H',
  '#82c7ec': 'CTRL-SHIFT-I',
  '#81edda': 'CTRL-SHIFT-J',
  '#b183eb': 'CTRL-SHIFT-K',
  '#ea84b9': 'CTRL-SHIFT-J',
  '#8393eb': 'CTRL-SHIFT-M',
  '#81eda2': 'CTRL-SHIFT-N',
  '#ea84ea': 'CTRL-SHIFT-O',
  '#ea849b': 'CTRL-SHIFT-P',
  '#c9f4a6': 'CTRL-SHIFT-T',
  '#baec82': 'CTRL-SHIFT-U',
  '#f4f2a6': 'CTRL-SHIFT-V',
  '#a6c4f4': 'CTRL-SHIFT-X',
  '#f4aaa6': 'CTRL-SHIFT-Y',
  '#bba6f4': 'CTRL-SHIFT-Z',
  '#28232c': 'SHIFT-F1',
  '#b8ab9e': 'SHIFT-F2',
  '#3f3d4e': 'SHIFT-F3',
  '#b8a59e': 'SHIFT-F4',
  '#b8b19e': 'SHIFT-F5',
  '#30373f': 'SHIFT-F6',
  '#9eabb8': 'SHIFT-F7',
  '#9ea5b8': 'SHIFT-F8',
  '#9eb8b1': 'SHIFT-F9',
  '#b89eab': 'SHIFT-F10',
  '#b1b89e': 'SHIFT-F11',
  '#abb89e': 'SHIFT-F12',
  '#8e4065': 'ALT-F1',
  '#c477b6': 'ALT-F2',
  '#8c4aac': 'ALT-F3',
  '#8c76c7': 'ALT-F4',
  '#4552ab': 'ALT-F5',
  '#81bcc5': 'ALT-F6',
  '#58b474': 'ALT-F7',
  '#9fd599': 'ALT-F8',
  '#9ebe5c': 'ALT-F9',
  '#989138': 'ALT-F10',
  '#dcbda0': 'ALT-F11',
  '#7e3a3a': 'ALT-F12',
  '#795e4d': 'F5',
  '#49623e': 'F6',
  '#30ad72': 'F7',
  '#963ea6': 'F8',
  '#337d49': 'F9',
  '#437e98': 'F10',
  '#77a9b0': 'F11',
  '#1e1c68': 'F12'
};

export const color_mappings_ZHUZHU: Record<string, string> = {
  '#6dfa45': 'SHIFT-F1',
  '#58b474': 'SHIFT-F2',
  '#dfe244': 'SHIFT-F3',
  '#e6e93e': 'SHIFT-F4',
  '#eda08d': 'SHIFT-F5',
  '#9ebe5c': 'SHIFT-F6',
  '#9b8cee': 'SHIFT-F7',
  '#887788': 'SHIFT-F8',
  '#dbdd18': 'SHIFT-F10',
  '#f7aeae': 'CTRL-F1',
  '#884488': 'CTRL-F2',
  '#885588': 'CTRL-F3',
  '#886688': 'CTRL-F4',
  '#2d1b7b': 'CTRL-F5',
  '#31deed': 'CTRL-F6',
  '#34e76f': 'CTRL-F7',
  '#3f25b0': 'CTRL-F8',
  '#5933ff': 'CTRL-F9',
  '#6cd533': 'CTRL-F10',
  '#882288': 'ALT-NUMPAD1',
  '#919439': 'ALT-NUMPAD2',
  '#a1a440': 'ALT-NUMPAD3',
  '#adb046': 'ALT-NUMPAD4',
  '#4476fb': 'ALT-NUMPAD5',
  '#f744fb': 'ALT-NUMPAD6',
  '#d2ed8d': 'ALT-NUMPAD7',
  '#d4d746': 'ALT-NUMPAD8',
  '#883388': 'ALT-NUMPAD9',
  '#ef8fbd': 'ALT-NUMPAD0',
  '#4552ab': 'CTRL-NUMPAD1',
  '#9571e8': 'CTRL-NUMPAD2',
  '#881188': 'CTRL-NUMPAD3',
  '#9fd599': 'CTRL-NUMPAD4',
  '#9644fb': 'CTRL-NUMPAD5',
  '#8c4aac': 'CTRL-NUMPAD6',
  '#81bcc5': 'CTRL-NUMPAD7',
  '#8c76c7': 'CTRL-NUMPAD8',
  '#e48cee': 'CTRL-NUMPAD9',
  '#8e4065': 'CTRL-NUMPAD0',
  '#989138': 'NUMPAD1',
  '#edda8d': 'NUMPAD2',
  '#a6ed8d': 'NUMPAD3',
  '#fb4496': 'NUMPAD4',
  '#f9e746': 'NUMPAD5',
  '#88aa88': 'NUMPAD6',
  '#bd8ded': 'NUMPAD7',
  '#f9ddb7': 'NUMPAD8',
  '#f5f9b7': 'NUMPAD9',
  '#ee8cdb': 'NUMPAD0',
  '#c477b6': 'SHIFT-=',
  '#27a5b0': 'SHIFT--',
  '#28ac53': 'SHIFT-P',
  '#f7c2ae': 'SHIFT-O',
  '#ef8f92': 'SHIFT-I',
  '#e673c4': 'SHIFT-L',
  '#f78a48': 'SHIFT-K',
  '#888888': 'CTRL-J',
  // '#f7aeae': 'SHIFT-F9',
  // SHIFT-j
  // SHIFT-m
  // SHIFT-n
  // CTRL-=
  // CTRL--
  // CTRL-p
  // CTRL-o
  // CTRL-i
  // CTRL-l
  // CTRL-k
  // CTRL-j
  // CTRL-m
  // CTRL-n
};

/** 猪猪一键宏 */
const CONFIG_XIAOYI_SS: { [key: string]: { color: string; com: string } } = {
  tab: {
    color: '149,9,0',
    com: 'TAB'
  },
  shadowBite: {
    color: '253,1,0',
    com: ''
  },
  kologarnTarget3: {
    color: '243,0,0',
    com: ''
  },
  cancelStormPower: {
    color: '133,0,0',
    com: ''
  },
  startMove: {
    color: '57,0,0',
    com: ''
  },
  casting: {
    color: '20,0,0',
    com: ''
  },
  shadowFlame: {
    color: '199,2,0',
    com: ''
  },
  na: {
    color: '0,0,0',
    com: ''
  },
  cd: {
    color: '10,0,0',
    com: ''
  },
  immofocus: {
    color: '211,4,0',
    com: 'ALT-CTRL-]'
  },
  immomouse: {
    color: '16,5,0',
    com: 'ALT-SHIFT-]'
  },
  immopet: {
    color: '88,5,0',
    com: 'ALT-CTRL-SHIFT-]'
  },
  immoparty1target: {
    color: '36,5,0',
    com: 'ALT-CTRL-N'
  },
  immoparty2target: {
    color: '11,4,0',
    com: 'ALT-SHIFT-N'
  },
  immoparty3target: {
    color: '52,5,0',
    com: 'ALT-CTRL-SHIFT-N'
  },
  immoparty4target: {
    color: '39,5,0',
    com: 'CTRL-L'
  },
  immoraid1target: {
    color: '49,4,0',
    com: 'CTRL-PAGEUP'
  },
  immoraid2target: {
    color: '208,3,0',
    com: 'ALT-PAGEUP'
  },
  immoraid3target: {
    color: '123,3,0',
    com: 'SHIFT-PAGEUP'
  },
  immoraid4target: {
    color: '92,4,0',
    com: 'CTRL-SHIFT-PAGEUP'
  },
  immoraid5target: {
    color: '86,4,0',
    com: 'ALT-CTRL-PAGEUP'
  },
  immoraid6target: {
    color: '29,4,0',
    com: 'ALT-SHIFT-PAGEUP'
  },
  immoraid7target: {
    color: '52,4,0',
    com: 'ALT-CTRL-SHIFT-PAGEUP'
  },
  immoraid8target: {
    color: '130,4,0',
    com: 'CTRL-PAGEDOWN'
  },
  immoraid9target: {
    color: '143,3,0',
    com: 'ALT-PAGEDOWN'
  },
  immoraid10target: {
    color: '146,4,0',
    com: 'SHIFT-PAGEDOWN'
  },
  immoraid11target: {
    color: '65,4,0',
    com: 'CTRL-SHIFT-PAGEDOWN'
  },
  immoraid12target: {
    color: '0,4,0',
    com: 'ALT-CTRL-PAGEDOWN'
  },
  immoraid13target: {
    color: '162,4,0',
    com: 'ALT-SHIFT-PAGEDOWN'
  },
  immoraid14target: {
    color: '182,4,0',
    com: 'ALT-CTRL-SHIFT-PAGEDOWN'
  },
  immoraid15target: {
    color: '101,4,0',
    com: 'CTRL-['
  },
  immoraid16target: {
    color: '110,4,0',
    com: 'ALT-['
  },
  immoraid17target: {
    color: '191,4,0',
    com: 'SHIFT-['
  },
  immoraid18target: {
    color: '81,4,0',
    com: 'CTRL-SHIFT-['
  },
  immoraid19target: {
    color: '167,4,0',
    com: 'ALT-CTRL-['
  },
  immoraid20target: {
    color: '243,4,0',
    com: 'ALT-SHIFT-NUMPAD5'
  },
  immoraid21target: {
    color: '214,4,0',
    com: 'ALT-CTRL-SHIFT-['
  },
  immoraid22target: {
    color: '254,4,0',
    com: 'CTRL-]'
  },
  immoraid23target: {
    color: '173,4,0',
    com: 'ALT-]'
  },
  immoraid24target: {
    color: '227,4,0',
    com: 'SHIFT-]'
  },
  immoraid25target: {
    color: '195,4,0',
    com: 'CTRL-SHIFT-]'
  },
  drainSoulraid12target: {
    color: '228,6,0',
    com: 'ALT-CTRL-NUMPADMINUS'
  },
  corruptionmouse: {
    color: '159,3,0',
    com: 'ALT-SHIFT-END'
  },
  corruptionraid19target: {
    color: '105,3,0',
    com: 'ALT-CTRL-HOME'
  },
  sbL1raid7target: {
    color: '159,8,0',
    com: 'ALT-CTRL-SHIFT-;'
  },
  sbL1raid1target: {
    color: '162,8,0',
    com: 'CTRL-;'
  },
  sear: {
    color: '153,1,0',
    com: 'CTRL-F3'
  },
  sbraid5target: {
    color: '175,7,0',
    com: 'ALT-CTRL-UP'
  },
  sbL1raid23target: {
    color: '68,9,0',
    com: 'ALT-.'
  },
  unAffparty2target: {
    color: '11,4,0',
    com: 'ALT-SHIFT-N'
  },
  sbL1raid2target: {
    color: '202,8,0',
    com: 'ALT-;'
  },
  shoot: {
    color: '101,0,0',
    com: 'SHIFT-F10'
  },
  sbfocus: {
    color: '81,8,0',
    com: 'ALT-CTRL-RIGHT'
  },
  burst1agony: {
    color: '23,1,0',
    com: 'ALT-CTRL-F5'
  },
  unAffraid14target: {
    color: '182,4,0',
    com: 'ALT-CTRL-SHIFT-PAGEDOWN'
  },
  focusXe321: {
    color: '247,0,0',
    com: 'SHIFT-NUMPAD1'
  },
  unAffraid1target: {
    color: '49,4,0',
    com: 'CTRL-PAGEUP'
  },
  unAffraid15target: {
    color: '101,4,0',
    com: 'CTRL-['
  },
  shadowWard: {
    color: '193,2,0',
    com: 'SHIFT-F8'
  },
  drainSoulraid14target: {
    color: '165,6,0',
    com: 'ALT-CTRL-SHIFT-NUMPADMINUS'
  },
  demonicEmpowerment: {
    color: '7,1,0',
    com: 'SHIFT-F3'
  },
  unAffraid19target: {
    color: '167,4,0',
    com: 'ALT-CTRL-['
  },
  sbL1raid14target: {
    color: '220,8,0',
    com: "ALT-CTRL-SHIFT-'"
  },
  agonyraid23target: {
    color: '7,5,0',
    com: 'ALT-NUMPAD9'
  },
  sbL1raid25target: {
    color: '126,9,0',
    com: 'CTRL-SHIFT-.'
  },
  tarBoss2: {
    color: '104,0,0',
    com: 'ALT-NUMPAD0'
  },
  drainSoulraid3target: {
    color: '84,6,0',
    com: 'SHIFT-NUMPADPLUS'
  },
  burst3lifeTap: {
    color: '112,2,0',
    com: 'ALT-SHIFT-F7'
  },
  focusBoneSpike: {
    color: '227,9,0',
    com: 'ALT-SHIFT-NUMPAD0'
  },
  unAfffocus: {
    color: '211,4,0',
    com: 'ALT-CTRL-]'
  },
  sbparty4target: {
    color: '139,8,0',
    com: 'CTRL-SHIFT-7'
  },
  corruptionraid7target: {
    color: '127,2,0',
    com: 'ALT-CTRL-SHIFT-INSERT'
  },
  burst3drainSoul: {
    color: '136,2,0',
    com: 'ALT-CTRL-SHIFT-F7'
  },
  tarEnemy: {
    color: '198,0,0',
    com: 'ALT-CTRL-NUMPAD0'
  },
  corruptionpet: {
    color: '204,3,0',
    com: 'ALT-CTRL-SHIFT-END'
  },
  corruptionraid8target: {
    color: '46,3,0',
    com: 'CTRL-DELETE'
  },
  sbL1raid3target: {
    color: '58,8,0',
    com: 'SHIFT-;'
  },
  burst2drainSoul: {
    color: '91,2,0',
    com: 'ALT-CTRL-SHIFT-F6'
  },
  agonyraid22target: {
    color: '201,5,0',
    com: 'CTRL-NUMPAD9'
  },
  sbL1focus: {
    color: '198,9,0',
    com: 'ALT-CTRL-.'
  },
  haunt: {
    color: '10,1,0',
    com: 'ALT-F1'
  },
  sbraid4target: {
    color: '94,7,0',
    com: 'CTRL-SHIFT-UP'
  },
  burst2unAff: {
    color: '107,2,0',
    com: 'SHIFT-F6'
  },
  sbL1raid11target: {
    color: '253,7,0',
    com: "CTRL-SHIFT-'"
  },
  agonyraid18target: {
    color: '250,5,0',
    com: 'CTRL-SHIFT-NUMPAD8'
  },
  agonyraid3target: {
    color: '20,5,0',
    com: 'SHIFT-NUMPAD6'
  },
  sbL1raid13target: {
    color: '21,9,0',
    com: "ALT-SHIFT-'"
  },
  seedfocus: {
    color: '250,1,0',
    com: 'ALT-CTRL-F4'
  },
  drainSoulraid1target: {
    color: '133,5,0',
    com: 'CTRL-NUMPADPLUS'
  },
  sbraid13target: {
    color: '188,7,0',
    com: 'ALT-SHIFT-DOWN'
  },
  sbL1raid12target: {
    color: '36,9,0',
    com: "ALT-CTRL-'"
  },
  corruptionLL9: {
    color: '237,2,0',
    com: 'ALT-CTRL-SHIFT-F8'
  },
  corruptionfocus: {
    color: '33,4,0',
    com: 'ALT-CTRL-END'
  },
  agonyparty2target: {
    color: '117,5,0',
    com: 'ALT-M'
  },
  healthStone: {
    color: '72,0,0',
    com: 'ALT-CTRL-SHIFT-F9'
  },
  focusLivingEmber: {
    color: '214,0,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD0'
  },
  corruptionraid13target: {
    color: '140,2,0',
    com: 'ALT-SHIFT-DELETE'
  },
  drainSoulraid11target: {
    color: '66,6,0',
    com: 'CTRL-SHIFT-NUMPADMINUS'
  },
  chaosBolt: {
    color: '153,0,0',
    com: 'ALT-CTRL-SHIFT-F2'
  },
  burst3corruption: {
    color: '156,2,0',
    com: 'ALT-F7'
  },
  agonyraid14target: {
    color: '214,5,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD7'
  },
  corruptionraid9target: {
    color: '94,3,0',
    com: 'ALT-DELETE'
  },
  sbraid17target: {
    color: '34,8,0',
    com: 'SHIFT-LEFT'
  },
  drainSoulmouse: {
    color: '53,7,0',
    com: 'ALT-SHIFT-NUMPADDIVIDE'
  },
  drainSoulparty3target: {
    color: '123,7,0',
    com: 'ALT-CTRL-SHIFT-M'
  },
  cancelHealthBuff: {
    color: '117,9,0',
    com: 'ALT-CTRL-SHIFT-F10'
  },
  sbraid3target: {
    color: '91,7,0',
    com: 'SHIFT-UP'
  },
  turn: {
    color: '102,9,0',
    com: 'ALT-F10'
  },
  eqSetSp: {
    color: '52,0,0',
    com: 'ALT-CTRL-F10'
  },
  corruptionraid2target: {
    color: '217,2,0',
    com: 'ALT-INSERT'
  },
  drainSoulraid17target: {
    color: '246,6,0',
    com: 'SHIFT-NUMPADMULTIPLY'
  },
  clearMirror: {
    color: '162,0,0',
    com: 'CTRL-SHIFT-NUMPAD0'
  },
  sbL1raid9target: {
    color: '191,8,0',
    com: "ALT-'"
  },
  corruptionraid20target: {
    color: '253,2,0',
    com: 'ALT-SHIFT-HOME'
  },
  agonyraid7target: {
    color: '68,5,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD6'
  },
  burst3sb: {
    color: '131,1,0',
    com: 'CTRL-F7'
  },
  sbL1raid16target: {
    color: '27,9,0',
    com: 'ALT-,'
  },
  sbL1party1target: {
    color: '162,9,0',
    com: 'ALT-CTRL-7'
  },
  sbL1raid24target: {
    color: '146,9,0',
    com: 'SHIFT-.'
  },
  drainSoulraid4target: {
    color: '156,6,0',
    com: 'CTRL-SHIFT-NUMPADPLUS'
  },
  agonyraid25target: {
    color: '26,6,0',
    com: 'CTRL-SHIFT-NUMPAD9'
  },
  unAffraid20target: {
    color: '243,4,0',
    com: 'ALT-SHIFT-NUMPAD5'
  },
  corruptionparty4target: {
    color: '5,4,0',
    com: 'CTRL-SHIFT-N'
  },
  drainSoulraid13target: {
    color: '222,6,0',
    com: 'ALT-SHIFT-NUMPADMINUS'
  },
  drainSoulraid20target: {
    color: '188,6,0',
    com: 'ALT-SHIFT-NUMPADMULTIPLY'
  },
  seedmouseover: {
    color: '172,1,0',
    com: 'CTRL-SHIFT-F4'
  },
  lifeTap: {
    color: '225,0,0',
    com: 'ALT-CTRL-SHIFT-F1'
  },
  corruptionraid16target: {
    color: '175,3,0',
    com: 'ALT-HOME'
  },
  burst2agony: {
    color: '118,2,0',
    com: 'ALT-CTRL-F6'
  },
  shadowfury: {
    color: '72,1,0',
    com: 'ALT-F3'
  },
  sbL1raid17target: {
    color: '65,9,0',
    com: 'SHIFT-,'
  },
  corruptionraid25target: {
    color: '227,3,0',
    com: 'CTRL-SHIFT-END'
  },
  teleport: {
    color: '201,1,0',
    com: 'ALT-CTRL-F3'
  },
  agonyparty3target: {
    color: '39,6,0',
    com: 'SHIFT-M'
  },
  agonyraid9target: {
    color: '154,5,0',
    com: 'ALT-NUMPAD7'
  },
  sbraid14target: {
    color: '29,8,0',
    com: 'ALT-CTRL-SHIFT-DOWN'
  },
  gate: {
    color: '206,1,0',
    com: 'CTRL-F4'
  },
  tarBoss3: {
    color: '182,0,0',
    com: 'SHIFT-NUMPAD0'
  },
  corruptionparty3target: {
    color: '20,4,0',
    com: 'SHIFT-N'
  },
  drainSoulraid25target: {
    color: '71,7,0',
    com: 'CTRL-SHIFT-NUMPADDIVIDE'
  },
  burst1unAff: {
    color: '212,1,0',
    com: 'SHIFT-F5'
  },
  drainSoulfocus: {
    color: '134,7,0',
    com: 'ALT-CTRL-NUMPADDIVIDE'
  },
  agonymouse: {
    color: '23,6,0',
    com: 'ALT-SHIFT-NUMPAD9'
  },
  unAffraid9target: {
    color: '143,3,0',
    com: 'ALT-PAGEDOWN'
  },
  unAffraid24target: {
    color: '227,4,0',
    com: 'SHIFT-]'
  },
  burst2: {
    color: '36,0,0',
    com: 'SHIFT-F9'
  },
  stopCasting: {
    color: '207,9,0',
    com: 'CTRL-F9'
  },
  drainSoulraid22target: {
    color: '201,6,0',
    com: 'CTRL-NUMPADDIVIDE'
  },
  immoAura: {
    color: '125,1,0',
    com: 'ALT-CTRL-SHIFT-F3'
  },
  sbL1raid18target: {
    color: '97,9,0',
    com: 'CTRL-SHIFT-,'
  },
  agonyraid20target: {
    color: '7,6,0',
    com: 'ALT-SHIFT-NUMPAD8'
  },
  unAffpet: {
    color: '88,5,0',
    com: 'ALT-CTRL-SHIFT-]'
  },
  corruptionraid12target: {
    color: '127,3,0',
    com: 'ALT-CTRL-DELETE'
  },
  agonyraid6target: {
    color: '149,5,0',
    com: 'ALT-SHIFT-NUMPAD6'
  },
  agonypet: {
    color: '120,6,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD9'
  },
  agonyparty4target: {
    color: '75,6,0',
    com: 'CTRL-SHIFT-M'
  },
  agonyraid17target: {
    color: '230,5,0',
    com: 'SHIFT-NUMPAD8'
  },
  corruptionraid22target: {
    color: '224,3,0',
    com: 'CTRL-END'
  },
  burst1haunt: {
    color: '46,2,0',
    com: 'CTRL-SHIFT-F5'
  },
  feedPet: {
    color: '88,1,0',
    com: 'SHIFT-F4'
  },
  saronite: {
    color: '130,9,0',
    com: 'ALT-SHIFT-F9'
  },
  drainSoulraid7target: {
    color: '88,6,0',
    com: 'ALT-CTRL-SHIFT-NUMPADPLUS'
  },
  doom: {
    color: '104,1,0',
    com: 'ALT-F2'
  },
  sbraid21target: {
    color: '128,7,0',
    com: 'ALT-CTRL-SHIFT-LEFT'
  },
  unAffraid8target: {
    color: '130,4,0',
    com: 'CTRL-PAGEDOWN'
  },
  unAffraid10target: {
    color: '146,4,0',
    com: 'SHIFT-PAGEDOWN'
  },
  drainSoulraid21target: {
    color: '42,7,0',
    com: 'ALT-CTRL-SHIFT-NUMPADMULTIPLY'
  },
  incinerate: {
    color: '68,1,0',
    com: 'ALT-CTRL-F2'
  },
  drainSoulraid19target: {
    color: '147,6,0',
    com: 'ALT-CTRL-NUMPADMULTIPLY'
  },
  rocketBoot: {
    color: '63,0,0',
    com: 'CTRL-F10'
  },
  sbraid7target: {
    color: '152,7,0',
    com: 'ALT-CTRL-SHIFT-UP'
  },
  unAffraid17target: {
    color: '191,4,0',
    com: 'SHIFT-['
  },
  sbL1party3target: {
    color: '224,8,0',
    com: 'ALT-CTRL-SHIFT-7'
  },
  burst2sb: {
    color: '221,1,0',
    com: 'CTRL-F6'
  },
  drainSoulraid16target: {
    color: '10,7,0',
    com: 'ALT-NUMPADMULTIPLY'
  },
  unAffraid4target: {
    color: '92,4,0',
    com: 'CTRL-SHIFT-PAGEUP'
  },
  corruptionraid11target: {
    color: '33,3,0',
    com: 'CTRL-SHIFT-DELETE'
  },
  drainSoulraid10target: {
    color: '217,6,0',
    com: 'SHIFT-NUMPADMINUS'
  },
  sbL1raid6target: {
    color: '240,8,0',
    com: 'ALT-SHIFT-;'
  },
  agonyraid19target: {
    color: '169,5,0',
    com: 'ALT-CTRL-NUMPAD8'
  },
  sbL1raid20target: {
    color: '108,9,0',
    com: 'ALT-SHIFT-,'
  },
  unAff: {
    color: '166,0,0',
    com: 'CTRL-SHIFT-F1'
  },
  tarLight: {
    color: '185,0,0',
    com: 'ALT-CTRL-NUMPAD1'
  },
  sbraid2target: {
    color: '172,7,0',
    com: 'ALT-UP'
  },
  burst2lifeTap: {
    color: '37,2,0',
    com: 'ALT-SHIFT-F6'
  },
  burst1corruption: {
    color: '234,1,0',
    com: 'ALT-F5'
  },
  drainSoulparty1target: {
    color: '13,7,0',
    com: 'ALT-CTRL-M'
  },
  sbraid23target: {
    color: '13,8,0',
    com: 'ALT-RIGHT'
  },
  sbraid24target: {
    color: '62,8,0',
    com: 'SHIFT-RIGHT'
  },
  sbraid6target: {
    color: '62,7,0',
    com: 'ALT-SHIFT-UP'
  },
  sbraid8target: {
    color: '224,7,0',
    com: 'CTRL-DOWN'
  },
  unAffraid3target: {
    color: '123,3,0',
    com: 'SHIFT-PAGEUP'
  },
  sbraid22target: {
    color: '94,8,0',
    com: 'CTRL-RIGHT'
  },
  doomfocus: {
    color: '10,2,0',
    com: 'CTRL-F8'
  },
  willToSurvive: {
    color: '144,0,0',
    com: 'ALT-SHIFT-F10'
  },
  sbmouse: {
    color: '115,8,0',
    com: 'ALT-SHIFT-RIGHT'
  },
  agonyraid11target: {
    color: '120,5,0',
    com: 'CTRL-SHIFT-NUMPAD7'
  },
  corruptionraid6target: {
    color: '240,2,0',
    com: 'ALT-SHIFT-INSERT'
  },
  drainSoulparty4target: {
    color: '136,6,0',
    com: 'ALT-L'
  },
  corruptionraid5target: {
    color: '42,3,0',
    com: 'ALT-CTRL-INSERT'
  },
  sbraid19target: {
    color: '0,8,0',
    com: 'ALT-CTRL-LEFT'
  },
  drainSoulraid5target: {
    color: '141,6,0',
    com: 'ALT-CTRL-NUMPADPLUS'
  },
  sbraid20target: {
    color: '78,8,0',
    com: 'ALT-SHIFT-LEFT'
  },
  unAffraid12target: {
    color: '0,4,0',
    com: 'ALT-CTRL-PAGEDOWN'
  },
  corruptionraid14target: {
    color: '65,3,0',
    com: 'ALT-CTRL-SHIFT-DELETE'
  },
  corruptionraid1target: {
    color: '208,2,0',
    com: 'CTRL-INSERT'
  },
  conflagrate: {
    color: '140,1,0',
    com: 'ALT-SHIFT-F2'
  },
  doommouseover: {
    color: '230,1,0',
    com: 'ALT-CTRL-SHIFT-F4'
  },
  burst2corruption: {
    color: '31,2,0',
    com: 'ALT-F6'
  },
  sbpet: {
    color: '233,7,0',
    com: 'ALT-CTRL-SHIFT-RIGHT'
  },
  clearFocus: {
    color: '117,0,0',
    com: 'CTRL-MOUSEWHEELDOWN'
  },
  lifeTapL4: {
    color: '24,3,0',
    com: 'SHIFT-K'
  },
  unAffparty4target: {
    color: '39,5,0',
    com: 'CTRL-L'
  },
  unAffparty1target: {
    color: '36,5,0',
    com: 'ALT-CTRL-N'
  },
  agonyraid1target: {
    color: '133,4,0',
    com: 'CTRL-NUMPAD6'
  },
  sbL1mouse: {
    color: '49,9,0',
    com: 'ALT-SHIFT-.'
  },
  burst3haunt: {
    color: '172,2,0',
    com: 'CTRL-SHIFT-F7'
  },
  corruptionraid15target: {
    color: '99,3,0',
    com: 'CTRL-HOME'
  },
  drainSoul: {
    color: '59,1,0',
    com: 'ALT-SHIFT-F1'
  },
  unAffraid22target: {
    color: '254,4,0',
    com: 'CTRL-]'
  },
  agonyraid4target: {
    color: '79,5,0',
    com: 'CTRL-SHIFT-NUMPAD6'
  },
  tarDark: {
    color: '23,0,0',
    com: 'ALT-SHIFT-NUMPAD1'
  },
  corruptionraid10target: {
    color: '114,3,0',
    com: 'SHIFT-DELETE'
  },
  inferno: {
    color: '120,1,0',
    com: 'ALT-SHIFT-F3'
  },
  unAffraid13target: {
    color: '162,4,0',
    com: 'ALT-SHIFT-PAGEDOWN'
  },
  burst1drainSoul: {
    color: '55,2,0',
    com: 'ALT-CTRL-SHIFT-F5'
  },
  corruptionraid17target: {
    color: '146,3,0',
    com: 'SHIFT-HOME'
  },
  agonyraid16target: {
    color: '182,5,0',
    com: 'ALT-NUMPAD8'
  },
  cancelToT: {
    color: '188,2,0',
    com: 'ALT-K'
  },
  agonyraid2target: {
    color: '101,5,0',
    com: 'ALT-NUMPAD6'
  },
  tarBoss1: {
    color: '81,0,0',
    com: 'CTRL-NUMPAD0'
  },
  burst2haunt: {
    color: '149,1,0',
    com: 'CTRL-SHIFT-F6'
  },
  corruptionraid4target: {
    color: '62,3,0',
    com: 'CTRL-SHIFT-INSERT'
  },
  corruptionraid24target: {
    color: '240,3,0',
    com: 'SHIFT-END'
  },
  agonyraid5target: {
    color: '114,4,0',
    com: 'ALT-CTRL-NUMPAD6'
  },
  agony: {
    color: '219,0,0',
    com: 'ALT-CTRL-F1'
  },
  immo: {
    color: '91,1,0',
    com: 'SHIFT-F2'
  },
  unAffraid23target: {
    color: '173,4,0',
    com: 'ALT-]'
  },
  sbparty2target: {
    color: '49,8,0',
    com: 'ALT-7'
  },
  sbL1raid22target: {
    color: '45,9,0',
    com: 'CTRL-.'
  },
  unAffparty3target: {
    color: '52,5,0',
    com: 'ALT-CTRL-SHIFT-N'
  },
  sbL1raid8target: {
    color: '0,9,0',
    com: "CTRL-'"
  },
  burst1: {
    color: '243,8,0',
    com: 'ALT-F9'
  },
  sbL1raid15target: {
    color: '110,8,0',
    com: 'CTRL-,'
  },
  burst2Critical: {
    color: '13,3,0',
    com: 'CTRL-K'
  },
  agonyraid8target: {
    color: '160,5,0',
    com: 'CTRL-NUMPAD7'
  },
  searLL8: {
    color: '221,2,0',
    com: 'CTRL-SHIFT-F8'
  },
  drainSoulparty2target: {
    color: '47,7,0',
    com: 'ALT-SHIFT-M'
  },
  sbL1raid5target: {
    color: '211,8,0',
    com: 'ALT-CTRL-;'
  },
  unAffraid7target: {
    color: '52,4,0',
    com: 'ALT-CTRL-SHIFT-PAGEUP'
  },
  soulFire: {
    color: '44,1,0',
    com: 'CTRL-SHIFT-F2'
  },
  sbparty1target: {
    color: '130,8,0',
    com: 'CTRL-7'
  },
  deathCoil: {
    color: '78,2,0',
    com: 'ALT-CTRL-F8'
  },
  sbraid11target: {
    color: '156,7,0',
    com: 'CTRL-SHIFT-DOWN'
  },
  sbraid12target: {
    color: '215,7,0',
    com: 'ALT-CTRL-DOWN'
  },
  agonyraid12target: {
    color: '248,4,0',
    com: 'ALT-CTRL-NUMPAD7'
  },
  sbraid10target: {
    color: '237,7,0',
    com: 'SHIFT-DOWN'
  },
  seed: {
    color: '138,0,0',
    com: 'CTRL-F2'
  },
  burst3unAff: {
    color: '75,2,0',
    com: 'SHIFT-F7'
  },
  unAffraid16target: {
    color: '110,4,0',
    com: 'ALT-['
  },
  unAffraid11target: {
    color: '65,4,0',
    com: 'CTRL-SHIFT-PAGEDOWN'
  },
  corruptionraid21target: {
    color: '195,3,0',
    com: 'ALT-CTRL-SHIFT-HOME'
  },
  sbraid18target: {
    color: '204,7,0',
    com: 'CTRL-SHIFT-LEFT'
  },
  unAffraid6target: {
    color: '29,4,0',
    com: 'ALT-SHIFT-PAGEUP'
  },
  unAffraid25target: {
    color: '195,4,0',
    com: 'CTRL-SHIFT-]'
  },
  agonyraid13target: {
    color: '178,5,0',
    com: 'ALT-SHIFT-NUMPAD7'
  },
  unAffraid21target: {
    color: '214,4,0',
    com: 'ALT-CTRL-SHIFT-['
  },
  sbL1raid4target: {
    color: '175,8,0',
    com: 'CTRL-SHIFT-;'
  },
  drainSoulraid23target: {
    color: '107,6,0',
    com: 'ALT-NUMPADDIVIDE'
  },
  drainSoulraid8target: {
    color: '241,5,0',
    com: 'CTRL-NUMPADMINUS'
  },
  sbL1raid19target: {
    color: '16,9,0',
    com: 'ALT-CTRL-,'
  },
  agonyfocus: {
    color: '104,6,0',
    com: 'ALT-CTRL-NUMPAD9'
  },
  sbraid1target: {
    color: '143,7,0',
    com: 'CTRL-UP'
  },
  sbL1party2target: {
    color: '81,9,0',
    com: 'ALT-SHIFT-7'
  },
  drainSoulraid24target: {
    color: '75,7,0',
    com: 'SHIFT-NUMPADDIVIDE'
  },
  unAffraid5target: {
    color: '86,4,0',
    com: 'ALT-CTRL-PAGEUP'
  },
  drainSoulraid18target: {
    color: '26,7,0',
    com: 'CTRL-SHIFT-NUMPADMULTIPLY'
  },
  sbparty3target: {
    color: '143,8,0',
    com: 'SHIFT-7'
  },
  agonyraid24target: {
    color: '55,6,0',
    com: 'SHIFT-NUMPAD9'
  },
  drainSoulraid15target: {
    color: '3,6,0',
    com: 'CTRL-NUMPADMULTIPLY'
  },
  sbL1party4target: {
    color: '178,9,0',
    com: 'SHIFT-L'
  },
  sapper: {
    color: '189,9,0',
    com: 'ALT-CTRL-F9'
  },
  sbL1raid10target: {
    color: '196,8,0',
    com: "SHIFT-'"
  },
  unAffmouse: {
    color: '16,5,0',
    com: 'ALT-SHIFT-]'
  },
  agonyraid21target: {
    color: '198,5,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD8'
  },
  agonyraid10target: {
    color: '97,5,0',
    com: 'SHIFT-NUMPAD7'
  },
  drainSoulraid9target: {
    color: '185,6,0',
    com: 'ALT-NUMPADMINUS'
  },
  burst3: {
    color: '183,9,0',
    com: 'CTRL-SHIFT-F9'
  },
  corruptionraid3target: {
    color: '26,2,0',
    com: 'SHIFT-INSERT'
  },
  burst1sb: {
    color: '185,1,0',
    com: 'CTRL-F5'
  },
  corruptionraid23target: {
    color: '78,3,0',
    com: 'ALT-END'
  },
  drainSoulraid6target: {
    color: '169,6,0',
    com: 'ALT-SHIFT-NUMPADPLUS'
  },
  burst3agony: {
    color: '159,2,0',
    com: 'ALT-CTRL-F7'
  },
  shatter: {
    color: '169,1,0',
    com: 'CTRL-SHIFT-F3'
  },
  sbL1pet: {
    color: '211,9,0',
    com: 'ALT-CTRL-SHIFT-.'
  },
  drainSoulraid2target: {
    color: '60,6,0',
    com: 'ALT-NUMPADPLUS'
  },
  corruptionparty2target: {
    color: '18,3,0',
    com: 'ALT-N'
  },
  sbraid25target: {
    color: '107,7,0',
    com: 'CTRL-SHIFT-RIGHT'
  },
  focusValkyr: {
    color: '234,0,0',
    com: 'CTRL-NUMPAD1'
  },
  sbraid16target: {
    color: '40,8,0',
    com: 'ALT-LEFT'
  },
  corruption: {
    color: '50,1,0',
    com: 'SHIFT-F1'
  },
  agonyraid15target: {
    color: '73,5,0',
    com: 'CTRL-NUMPAD8'
  },
  sb: {
    color: '39,1,0',
    com: 'CTRL-F1'
  },
  unAffraid18target: {
    color: '81,4,0',
    com: 'CTRL-SHIFT-['
  },
  corruptionraid18target: {
    color: '186,3,0',
    com: 'CTRL-SHIFT-HOME'
  },
  sbL1raid21target: {
    color: '121,8,0',
    com: 'ALT-CTRL-SHIFT-,'
  },
  sbraid15target: {
    color: '250,6,0',
    com: 'CTRL-LEFT'
  },
  unAffraid2target: {
    color: '208,3,0',
    com: 'ALT-PAGEUP'
  },
  sbraid9target: {
    color: '209,7,0',
    com: 'ALT-DOWN'
  },
  corruptionparty1target: {
    color: '180,3,0',
    com: 'CTRL-N'
  },
  tarFlyGhost: {
    color: '85,0,0',
    com: 'ALT-NUMPAD1'
  },
  drainSoulpet: {
    color: '237,6,0',
    com: 'ALT-CTRL-SHIFT-NUMPADDIVIDE'
  },
  agonyparty1target: {
    color: '235,5,0',
    com: 'CTRL-M'
  },
  burst1lifeTap: {
    color: '59,2,0',
    com: 'ALT-SHIFT-F5'
  }
};
/** 小易SS一键宏 */
export const color_mappings_XIAOYI_SS = transferConfig(CONFIG_XIAOYI_SS);

const CONFIG_XIAOYI_LR = {
  stopCasting: {
    color: '193,3,0',
    com: ''
  },
  kologarnTarget3: {
    color: '212,0,0',
    com: ''
  },
  explosiveShot: {
    color: '9,1,0',
    com: 'CTRL-F2'
  },
  na: {
    color: '0,0,0',
    com: ''
  },
  backwardJump: {
    color: '143,1,0',
    com: ''
  },
  casting: {
    color: '20,0,0',
    com: ''
  },
  tab: {
    color: '63,0,0',
    com: 'TAB'
  },
  cd: {
    color: '10,0,0',
    com: ''
  },
  startMove: {
    color: '249,3,0',
    com: ''
  },
  stopMoveQE: {
    color: '73,0,0',
    com: ''
  },
  stopMove: {
    color: '116,0,0',
    com: ''
  },
  cancelStormPower: {
    color: '137,0,0',
    com: ''
  },
  chimera: {
    color: '97,0,0',
    com: 'CTRL-SHIFT-F1'
  },
  KillShotraid12target: {
    color: '9,2,0',
    com: 'ALT-CTRL-DELETE'
  },
  KillShotraid4target: {
    color: '196,1,0',
    com: 'CTRL-SHIFT-INSERT'
  },
  KillShot: {
    color: '233,0,0',
    com: 'ALT-F1'
  },
  Serpentraid14target: {
    color: '65,2,0',
    com: 'ALT-CTRL-SHIFT-PAGEDOWN'
  },
  Serpentraid1target: {
    color: '89,2,0',
    com: 'CTRL-PAGEUP'
  },
  Serpentraid22target: {
    color: '161,2,0',
    com: 'CTRL-]'
  },
  Serpentraid2target: {
    color: '153,2,0',
    com: 'ALT-PAGEUP'
  },
  Serpent: {
    color: '241,0,0',
    com: 'SHIFT-F1'
  },
  KillShotraid2target: {
    color: '33,1,0',
    com: 'ALT-INSERT'
  },
  KillShotraid22target: {
    color: '84,2,0',
    com: 'CTRL-END'
  },
  Esraid8target: {
    color: '164,3,0',
    com: 'CTRL-NUMPAD7'
  },
  Espet: {
    color: '153,3,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD9'
  },
  tarBoss2: {
    color: '41,4,0',
    com: 'ALT-NUMPAD0'
  },
  autoshot: {
    color: '52,1,0',
    com: 'CTRL-F4'
  },
  launcher: {
    color: '145,0,0',
    com: 'CTRL-F1'
  },
  tarEnemy: {
    color: '121,0,0',
    com: 'ALT-CTRL-NUMPAD0'
  },
  burst2: {
    color: '49,0,0',
    com: 'SHIFT-F9'
  },
  KillShotraid23target: {
    color: '41,2,0',
    com: 'ALT-END'
  },
  Esraid25target: {
    color: '47,4,0',
    com: 'CTRL-SHIFT-NUMPAD9'
  },
  EsL3: {
    color: '73,1,0',
    com: 'ALT-F2'
  },
  aimedShot: {
    color: '169,0,0',
    com: 'ALT-CTRL-F1'
  },
  KillShotraid20target: {
    color: '185,1,0',
    com: 'ALT-SHIFT-HOME'
  },
  forwardJump: {
    color: '95,1,0',
    com: 'CTRL-SHIFT-F4'
  },
  Esraid18target: {
    color: '97,3,0',
    com: 'CTRL-SHIFT-NUMPAD8'
  },
  Serpentraid7target: {
    color: '137,2,0',
    com: 'ALT-CTRL-SHIFT-PAGEUP'
  },
  Esraid2target: {
    color: '116,3,0',
    com: 'ALT-NUMPAD6'
  },
  multiShot: {
    color: '217,0,0',
    com: 'ALT-CTRL-SHIFT-F1'
  },
  killCommand: {
    color: '201,0,0',
    com: 'SHIFT-F3'
  },
  snakeTrap: {
    color: '249,0,0',
    com: 'CTRL-F5'
  },
  KillShotraid6target: {
    color: '217,1,0',
    com: 'ALT-SHIFT-INSERT'
  },
  turn: {
    color: '33,4,0',
    com: 'ALT-F10'
  },
  KillShotraid7target: {
    color: '169,1,0',
    com: 'ALT-CTRL-SHIFT-INSERT'
  },
  Serpentraid8target: {
    color: '201,2,0',
    com: 'CTRL-PAGEDOWN'
  },
  Serpentraid25target: {
    color: '25,3,0',
    com: 'CTRL-SHIFT-]'
  },
  Serpentraid11target: {
    color: '169,2,0',
    com: 'CTRL-SHIFT-PAGEDOWN'
  },
  Esraid22target: {
    color: '25,4,0',
    com: 'CTRL-NUMPAD9'
  },
  KillShotraid11target: {
    color: '201,1,0',
    com: 'CTRL-SHIFT-DELETE'
  },
  Esraid12target: {
    color: '57,3,0',
    com: 'ALT-CTRL-NUMPAD7'
  },
  Serpentraid5target: {
    color: '175,2,0',
    com: 'ALT-CTRL-PAGEUP'
  },
  raptor: {
    color: '57,1,0',
    com: 'ALT-CTRL-F3'
  },
  KillShotraid25target: {
    color: '113,2,0',
    com: 'CTRL-SHIFT-END'
  },
  Esraid13target: {
    color: '207,3,0',
    com: 'ALT-SHIFT-NUMPAD7'
  },
  Esraid15target: {
    color: '169,3,0',
    com: 'CTRL-NUMPAD8'
  },
  volley: {
    color: '193,0,0',
    com: 'ALT-CTRL-SHIFT-F2'
  },
  KillShotraid24target: {
    color: '105,2,0',
    com: 'SHIFT-END'
  },
  Esraid11target: {
    color: '159,3,0',
    com: 'CTRL-SHIFT-NUMPAD7'
  },
  burst1: {
    color: '41,0,0',
    com: 'ALT-F9'
  },
  Serpentraid12target: {
    color: '228,2,0',
    com: 'ALT-CTRL-PAGEDOWN'
  },
  focusValkyr: {
    color: '207,0,0',
    com: 'CTRL-NUMPAD1'
  },
  Esraid7target: {
    color: '73,3,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD6'
  },
  KillShotraid5target: {
    color: '153,1,0',
    com: 'ALT-CTRL-INSERT'
  },
  Esraid17target: {
    color: '241,3,0',
    com: 'SHIFT-NUMPAD8'
  },
  tarBoss3: {
    color: '105,0,0',
    com: 'SHIFT-NUMPAD0'
  },
  clearMirror: {
    color: '164,0,0',
    com: 'CTRL-SHIFT-NUMPAD0'
  },
  dragonhawk: {
    color: '255,0,0',
    com: 'CTRL-SHIFT-F2'
  },
  KillShotraid16target: {
    color: '36,2,0',
    com: 'ALT-HOME'
  },
  blackArrow: {
    color: '81,1,0',
    com: 'ALT-SHIFT-F2'
  },
  Esfocus: {
    color: '52,4,0',
    com: 'ALT-CTRL-NUMPAD9'
  },
  Serpentraid4target: {
    color: '25,2,0',
    com: 'CTRL-SHIFT-PAGEUP'
  },
  Esraid19target: {
    color: '201,3,0',
    com: 'ALT-CTRL-NUMPAD8'
  },
  Serpentraid15target: {
    color: '223,2,0',
    com: 'CTRL-['
  },
  Serpentraid6target: {
    color: '180,2,0',
    com: 'ALT-SHIFT-PAGEUP'
  },
  sapper: {
    color: '57,4,0',
    com: 'ALT-CTRL-F9'
  },
  Esraid10target: {
    color: '185,3,0',
    com: 'SHIFT-NUMPAD7'
  },
  Serpentraid13target: {
    color: '185,2,0',
    com: 'ALT-SHIFT-PAGEDOWN'
  },
  focusBloodBeast: {
    color: '57,0,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD0'
  },
  Serpentraid24target: {
    color: '68,3,0',
    com: 'SHIFT-]'
  },
  Serpentraid10target: {
    color: '132,2,0',
    com: 'SHIFT-PAGEDOWN'
  },
  Esraid14target: {
    color: '105,3,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD7'
  },
  KillShotraid17target: {
    color: '191,1,0',
    com: 'SHIFT-HOME'
  },
  viper: {
    color: '25,1,0',
    com: 'SHIFT-F2'
  },
  Serpentmouse: {
    color: '63,3,0',
    com: 'ALT-SHIFT-]'
  },
  Esraid3target: {
    color: '49,3,0',
    com: 'SHIFT-NUMPAD6'
  },
  saronite: {
    color: '68,0,0',
    com: 'ALT-SHIFT-F9'
  },
  Esraid9target: {
    color: '121,3,0',
    com: 'ALT-NUMPAD7'
  },
  Esraid20target: {
    color: '4,4,0',
    com: 'ALT-SHIFT-NUMPAD8'
  },
  Esraid5target: {
    color: '145,3,0',
    com: 'ALT-CTRL-NUMPAD6'
  },
  KillShotraid1target: {
    color: '177,1,0',
    com: 'CTRL-INSERT'
  },
  KillShotraid14target: {
    color: '129,1,0',
    com: 'ALT-CTRL-SHIFT-DELETE'
  },
  KillShotraid21target: {
    color: '249,1,0',
    com: 'ALT-CTRL-SHIFT-HOME'
  },
  Esraid24target: {
    color: '212,3,0',
    com: 'SHIFT-NUMPAD9'
  },
  feedPet: {
    color: '148,1,0',
    com: 'ALT-CTRL-F4'
  },
  Serpentraid20target: {
    color: '41,3,0',
    com: 'ALT-SHIFT-NUMPAD5'
  },
  tarBoss1: {
    color: '89,0,0',
    com: 'CTRL-NUMPAD0'
  },
  Esraid21target: {
    color: '217,3,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD8'
  },
  KillShotfocus: {
    color: '225,1,0',
    com: 'ALT-CTRL-END'
  },
  tranqFocus: {
    color: '41,1,0',
    com: 'ALT-F3'
  },
  KillShotraid9target: {
    color: '239,1,0',
    com: 'ALT-DELETE'
  },
  Serpentfocus: {
    color: '89,3,0',
    com: 'ALT-CTRL-]'
  },
  burst3: {
    color: '73,4,0',
    com: 'CTRL-SHIFT-F9'
  },
  KillShotraid10target: {
    color: '244,1,0',
    com: 'SHIFT-DELETE'
  },
  rocketBoot: {
    color: '111,0,0',
    com: 'CTRL-F10'
  },
  Serpentraid21target: {
    color: '249,2,0',
    com: 'ALT-CTRL-SHIFT-['
  },
  Serpentraid17target: {
    color: '15,3,0',
    com: 'SHIFT-['
  },
  Serpentraid16target: {
    color: '121,2,0',
    com: 'ALT-['
  },
  Esraid16target: {
    color: '233,3,0',
    com: 'ALT-NUMPAD8'
  },
  Serpentpet: {
    color: '217,2,0',
    com: 'ALT-CTRL-SHIFT-]'
  },
  Serpentraid23target: {
    color: '9,3,0',
    com: 'ALT-]'
  },
  Esraid1target: {
    color: '111,3,0',
    com: 'CTRL-NUMPAD6'
  },
  KillShotmouse: {
    color: '73,2,0',
    com: 'ALT-SHIFT-END'
  },
  mark: {
    color: '153,0,0',
    com: 'ALT-CTRL-F2'
  },
  Serpentraid19target: {
    color: '233,2,0',
    com: 'ALT-CTRL-['
  },
  Esmouse: {
    color: '9,4,0',
    com: 'ALT-SHIFT-NUMPAD9'
  },
  Serpentraid18target: {
    color: '20,3,0',
    com: 'CTRL-SHIFT-['
  },
  KillShotraid15target: {
    color: '233,1,0',
    com: 'CTRL-HOME'
  },
  clearFocus: {
    color: '185,0,0',
    com: 'CTRL-MOUSEWHEELDOWN'
  },
  Esraid23target: {
    color: '255,3,0',
    com: 'ALT-NUMPAD9'
  },
  focusBoneSpike: {
    color: '159,0,0',
    com: 'ALT-SHIFT-NUMPAD0'
  },
  KillShotpet: {
    color: '79,2,0',
    com: 'ALT-CTRL-SHIFT-END'
  },
  frostTrap: {
    color: '121,1,0',
    com: 'ALT-SHIFT-F3'
  },
  KillShotraid8target: {
    color: '89,1,0',
    com: 'CTRL-DELETE'
  },
  Esraid4target: {
    color: '137,3,0',
    com: 'CTRL-SHIFT-NUMPAD6'
  },
  Serpentraid9target: {
    color: '209,2,0',
    com: 'ALT-PAGEDOWN'
  },
  missdFocus: {
    color: '100,1,0',
    com: 'CTRL-SHIFT-F3'
  },
  KillShotraid13target: {
    color: '17,2,0',
    com: 'ALT-SHIFT-DELETE'
  },
  Serpentraid3target: {
    color: '127,2,0',
    com: 'SHIFT-PAGEUP'
  },
  KillShotraid19target: {
    color: '31,2,0',
    com: 'ALT-CTRL-HOME'
  },
  feignDeath: {
    color: '47,1,0',
    com: 'CTRL-F3'
  },
  KillShotraid3target: {
    color: '137,1,0',
    com: 'SHIFT-INSERT'
  },
  healthStone: {
    color: '25,0,0',
    com: 'ALT-CTRL-SHIFT-F9'
  },
  mBite: {
    color: '105,1,0',
    com: 'ALT-CTRL-SHIFT-F4'
  },
  steadyShot: {
    color: '4,1,0',
    com: 'ALT-SHIFT-F1'
  },
  KillShotraid18target: {
    color: '57,2,0',
    com: 'CTRL-SHIFT-HOME'
  },
  Esraid6target: {
    color: '1,3,0',
    com: 'ALT-SHIFT-NUMPAD6'
  }
};
/** 小易LR一键宏 */
export const color_mappings_XIAOYI_LR = transferConfig(CONFIG_XIAOYI_LR);
