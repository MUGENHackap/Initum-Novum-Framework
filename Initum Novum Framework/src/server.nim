# src/server.nim
import asyncdispatch, asyncnet, strutils
import common

proc handleClient(client: AsyncSocket) {.async.} =
  while true:
    let data = await client.recv(4096)
    if data.len == 0:
      break
    let (_, msg) = parseMessage(data)
    echo "Received: ", msg
    await client.send(formatMessage("Echo: " & msg))
  await client.close()

proc startServer() {.async.} =
  let server = await newAsyncSocket()
  await server.bindAddr(Port(port), Host(host))
  server.listen()
  echo "Server listening on port ", port

  while true:
    let client = await server.accept()
    handleClient(client)

when isMainModule:
  waitFor startServer()

