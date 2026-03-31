import { getInitialSettings } from '../utils/settings/settings.js'

export function getSpinnerVerbs(): string[] {
  const settings = getInitialSettings()
  const config = settings.spinnerVerbs
  if (!config) {
    return SPINNER_VERBS
  }
  if (config.mode === 'replace') {
    return config.verbs.length > 0 ? config.verbs : SPINNER_VERBS
  }
  return [...SPINNER_VERBS, ...config.verbs]
}

// NERV MAGI system spinner verbs
export const SPINNER_VERBS = [
  // MAGI Processing
  'MAGI Analyzing',
  'MAGI Processing',
  'MAGI Consulting',
  'MAGI Deliberating',
  'Pattern Blue Scanning',
  'Pattern Orange Analyzing',
  'Sync Rate Calculating',
  'AT Field Calculating',
  'Harmonics Testing',

  // Subsystem Operations
  'CASPER Processing',
  'BALTHASAR Evaluating',
  'MELCHIOR Reasoning',
  'Terminal Dogma Accessing',
  'Central Dogma Querying',
  'Pribnow Box Monitoring',
  'Sigma Unit Calibrating',

  // System Status
  'Entry Plug Connecting',
  'LCL Pressurizing',
  'Umbilical Cable Routing',
  'S2 Engine Initializing',
  'Absolute Terror Field Deploying',
  'Progressive Knife Sharpening',
  'N2 Reactor Charging',
  'Dummy Plug Loading',

  // NERV Operations
  'GeoFront Mapping',
  'Eva Cage Preparing',
  'Launch Pad Aligning',
  'Catapult Charging',
  'Bakelite Injecting',
  'SEELE Protocol Decrypting',
  'Dead Sea Scrolls Parsing',
  'Human Instrumentality Evaluating',

  // Formal Operations
  'Code 601 Executing',
  'Priority Alpha Processing',
  'Protocol Verifying',
  'Clearance Authenticating',
  'Telemetry Correlating',
  'Waveform Analyzing',
  'Containment Monitoring',
  'Reconnaissance Compiling',
  'Tactical Assessing',
  'Strategic Modeling',
]
