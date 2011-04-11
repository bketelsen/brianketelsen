package main

import (
    "github.com/hoisie/web.go"
		"os"
	"log"
)

func hello(val string) string { return "hello " + val } 

func main() {
	f, err := os.Open("bkweb-server.log", os.O_RDWR|os.O_CREATE, 0644)
    if err != nil {
        println(err.String())
        return
    }
    logger := log.New(f, "", log.Ldate|log.Ltime)
    web.Get("/hello(.*)", hello)
	web.SetLogger(logger)
    web.Run("0.0.0.0:9999")
}