import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

// mpv --hwdec=help
enum HwDecType {
  no('no', '启用软解'),
  auto('auto', '启用任意可用解码器'),
  autoSafe('auto-safe', '启用最佳解码器'),
  autoCopy('auto-copy', '启用带拷贝功能的最佳解码器'),
  d3d12va('d3d12va', 'DirectX 12 (Windows10 及以上)'),
  d3d12vaCopy('d3d12va-copy', 'DirectX 12 (Windows10 及以上) (非直通)'),
  d3d11va('d3d11va', 'DirectX 11 (Windows8 及以上)'),
  d3d11vaCopy('d3d11va-copy', 'DirectX 11 (Windows8 及以上) (非直通)'),
  dxva2('dxva2', 'DXVA2 (Windows7 及以上)'),
  dxva2Copy('dxva2-copy', 'DXVA2 (Windows7 及以上) (非直通)'),
  videotoolbox('videotoolbox', 'VideoToolbox (macOS / iOS)'),
  videotoolboxCopy('videotoolbox-copy', 'VideoToolbox (macOS / iOS) (非直通)'),
  vaapi('vaapi', 'VAAPI (Linux)'),
  vaapiCopy('vaapi-copy', 'VAAPI (Linux) (非直通)'),
  nvdec('nvdec', 'NVDEC (NVIDIA独占)'),
  nvdecCopy('nvdec-copy', 'NVDEC (NVIDIA独占) (非直通)'),
  drm('drm', 'DRM (Linux)'),
  drmCopy('drm-copy', 'DRM (Linux) (非直通)'),
  vulkan('vulkan', 'Vulkan (全平台) (实验性)'),
  vulkanCopy('vulkan-copy', 'Vulkan (全平台) (实验性) (非直通)'),
  vdpau('vdpau', 'VDPAU (Linux)'),
  vdpauCopy('vdpau-copy', 'VDPAU (Linux) (非直通)'),
  mediacodec('mediacodec', 'MediaCodec (Android)'),
  mediacodecCopy('mediacodec-copy', 'MediaCodec (Android) (非直通)'),
  cuda('cuda', 'CUDA (NVIDIA独占) (过时)'),
  cudaCopy('cuda-copy', 'CUDA (NVIDIA独占) (过时) (非直通)'),
  crystalhd('crystalhd', 'CrystalHD (全平台) (过时)'),
  rkmpp('rkmpp', 'Rockchip MPP (仅部分Rockchip芯片)'),
  amf('amf', 'AMF (AMD独占)'),
  amfCopy('amf-copy', 'AMF (AMD独占) (非直通)'),
  qsv('qsv', 'Quick Sync Video (Intel独占)'),
  qsvCopy('qsv-copy', 'Quick Sync Video (Intel独占) (非直通)'),
  ;

  final String hwdec;
  final String desc;
  const HwDecType(this.hwdec, this.desc);

  String localizedDescription(AppLocalizations l10n) => switch (this) {
    .no => l10n.settingsHwdecSoftware,
    .auto => l10n.settingsHwdecAny,
    .autoSafe => l10n.settingsHwdecBest,
    .autoCopy => l10n.settingsHwdecBestCopy,
    .d3d12va => 'DirectX 12 (Windows 10+)',
    .d3d12vaCopy => 'DirectX 12 (Windows 10+, ${l10n.settingsHwdecNonDirect})',
    .d3d11va => 'DirectX 11 (Windows 8+)',
    .d3d11vaCopy => 'DirectX 11 (Windows 8+, ${l10n.settingsHwdecNonDirect})',
    .dxva2 => 'DXVA2 (Windows 7+)',
    .dxva2Copy => 'DXVA2 (Windows 7+, ${l10n.settingsHwdecNonDirect})',
    .videotoolbox => 'VideoToolbox (macOS / iOS)',
    .videotoolboxCopy =>
      'VideoToolbox (macOS / iOS, ${l10n.settingsHwdecNonDirect})',
    .vaapi => 'VAAPI (Linux)',
    .vaapiCopy => 'VAAPI (Linux, ${l10n.settingsHwdecNonDirect})',
    .nvdec => 'NVDEC (${l10n.settingsHwdecExclusive('NVIDIA')})',
    .nvdecCopy =>
      'NVDEC (${l10n.settingsHwdecExclusive('NVIDIA')}, ${l10n.settingsHwdecNonDirect})',
    .drm => 'DRM (Linux)',
    .drmCopy => 'DRM (Linux, ${l10n.settingsHwdecNonDirect})',
    .vulkan =>
      'Vulkan (${l10n.settingsHwdecAllPlatforms}, ${l10n.settingsHwdecExperimental})',
    .vulkanCopy =>
      'Vulkan (${l10n.settingsHwdecAllPlatforms}, ${l10n.settingsHwdecExperimental}, ${l10n.settingsHwdecNonDirect})',
    .vdpau => 'VDPAU (Linux)',
    .vdpauCopy => 'VDPAU (Linux, ${l10n.settingsHwdecNonDirect})',
    .mediacodec => 'MediaCodec (Android)',
    .mediacodecCopy => 'MediaCodec (Android, ${l10n.settingsHwdecNonDirect})',
    .cuda =>
      'CUDA (${l10n.settingsHwdecExclusive('NVIDIA')}, ${l10n.settingsHwdecDeprecated})',
    .cudaCopy =>
      'CUDA (${l10n.settingsHwdecExclusive('NVIDIA')}, ${l10n.settingsHwdecDeprecated}, ${l10n.settingsHwdecNonDirect})',
    .crystalhd =>
      'CrystalHD (${l10n.settingsHwdecAllPlatforms}, ${l10n.settingsHwdecDeprecated})',
    .rkmpp => 'Rockchip MPP (${l10n.settingsHwdecPartialRockchip})',
    .amf => 'AMF (${l10n.settingsHwdecExclusive('AMD')})',
    .amfCopy =>
      'AMF (${l10n.settingsHwdecExclusive('AMD')}, ${l10n.settingsHwdecNonDirect})',
    .qsv => 'Quick Sync Video (${l10n.settingsHwdecExclusive('Intel')})',
    .qsvCopy =>
      'Quick Sync Video (${l10n.settingsHwdecExclusive('Intel')}, ${l10n.settingsHwdecNonDirect})',
  };

  static final String androidDefault = [
    HwDecType.mediacodec.hwdec,
    HwDecType.autoSafe.hwdec,
  ].join(',');
}
