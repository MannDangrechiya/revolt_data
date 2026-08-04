# Security Policy

## Supported Versions

Only the latest `Production Candidate (v1.0.0)` release of `revolt_data` is supported for security updates.

| Version | Supported |
| :--- | :---: |
| 1.0.0 | YES |
| < 1.0.0 | NO |

---

## Reporting a Vulnerability

We take the security of `revolt_data` and the privacy of vehicle telemetry data very seriously.

If you discover a security vulnerability or sensitive data leak:

1. **Do NOT open a public GitHub issue.**
2. Send a private report detailing the vulnerability to `security@revoltev.dev` or maintainer contact `mann@printdeed.com`.
3. Include:
   - Type of issue (e.g. cleartext log exposure, unencrypted local database storage, credential leak)
   - Steps to reproduce
   - Potential impact
4. We will acknowledge receipt of your report within 48 hours and provide status updates as we address the vulnerability.

---

## Local Security Practices

- **Zero Cleartext Credentials**: `revolt_data` strips raw BLE pairing passkeys and authorization tokens from release build loggers.
- **On-Device Storage**: All application data remains local on your device inside an encrypted SQLite/Drift container. No telemetry is transmitted to third-party servers.
