# src/common.nim
import strformat

const
    port = 5400
    host = "127.0.0.1"

proc formatMessage(msg: string): string =
    return fmt"{len(msg):04d}{msg}"

proc parseMessege(data: string): (int, string) =
    let len = parseInt(data[0..3])
    let msg = data[4..<len+4]
    return (len, msg)
