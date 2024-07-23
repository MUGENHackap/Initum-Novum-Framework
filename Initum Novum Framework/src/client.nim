# src/client.nim
import asyncdispatch, asyncnet
import common

proc startClient() {.async.} =
  let socket = await newAsyncSocket()
  await socket.connect(Port(port), Host(host))
  echo "Connected to the server."

  let message = "Hello, Server!"
  await socket.send(formatMessage(message))
  let response = await socket.recv(4096)
  let (_, msg) = parseMessage(response)
  echo "Received: ", msg

  await socket.close()

when isMainModule:
  waitFor startClient()

