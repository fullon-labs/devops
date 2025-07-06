package main

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"encoding/base64"
	"encoding/hex"
	"fmt"
	"io"
	"strings"
)

const (
	Letters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	Rand    = "Q6qVmW89nhSWaKbX3hr3MbnPPUKzok7H"
)

func main() {
	randStr := RandomString(32)
	fmt.Print("请输入钱包账号：")

	var account string
	fmt.Scanln(&account)

	fmt.Print("请输入钱包私钥：")
	var privateKey string
	fmt.Scanln(&privateKey)

	// 加密
	ciphertext, nonce := encrypt([]byte(randStr), []byte(privateKey))

	fmt.Println("__________________________________________")
	fmt.Println("您的钱包账号: ", account)

	info := fmt.Sprintf("%s%x%x", randStr, ciphertext, nonce)

	// 加密2
	ciphertext2, nonce2 := encrypt([]byte(Rand), []byte(info))
	//info2 := fmt.Sprintf("%x%x", ciphertext2, nonce2)
	//fmt.Printf("您的钱包加密私钥: %s\n", info2)

	enbyte := append(ciphertext2, nonce2...)
	enString := base64.StdEncoding.EncodeToString(enbyte)

	fmt.Printf("您的钱包加密私钥, base64编码结果: %s\n", enString)
}

func parse(keys string) string {
	kbyte, err := base64.StdEncoding.DecodeString(keys)
	if err != nil {
		fmt.Printf("error decoding: %s\n", err)
		return ""
	}

	keyStr := hex.EncodeToString(kbyte)

	//解密
	key := decodeHex(keyStr[:len(keyStr)-24])
	nonce := decodeHex(keyStr[len(keyStr)-24:])

	mixPriKey := string(decrypt([]byte(Rand), key, nonce))

	//解密2
	rand2 := mixPriKey[:32]
	key2 := decodeHex(mixPriKey[32 : len(mixPriKey)-24])
	nonce2 := decodeHex(mixPriKey[len(mixPriKey)-24:])
	priKey := string(decrypt([]byte(rand2), key2, nonce2))

	return priKey
}

func decodeHex(s string) []byte {
	b, err := hex.DecodeString(s)
	if err != nil {
		panic(err)
	}
	return b
}

func encrypt(key, plaintext []byte) ([]byte, []byte) {
	block, err := aes.NewCipher(key)
	if err != nil {
		panic(err)
	}

	gcm, err := cipher.NewGCM(block)
	if err != nil {
		panic(err)
	}

	nonce := make([]byte, gcm.NonceSize())
	if _, err = io.ReadFull(rand.Reader, nonce); err != nil {
		panic(err)
	}

	ciphertext := gcm.Seal(nil, nonce, plaintext, nil)

	return ciphertext, nonce
}

func decrypt(key, ciphertext, nonce []byte) []byte {
	block, err := aes.NewCipher(key)
	if err != nil {
		panic(err)
	}
	gcm, err := cipher.NewGCM(block)
	if err != nil {
		panic(err)
	}
	b, err := gcm.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		panic(err)
	}
	return b
}

func RandFormString(char uint8) int {
	index := strings.IndexByte(Letters, char)
	if index == -1 {
		return 16
	}
	if index > 30 {
		return index % 30
	}
	return index
}

func RandomString(n int) string {
	bytes := make([]byte, n)
	rand.Read(bytes)
	for i, b := range bytes {
		bytes[i] = Letters[b%byte(len(Letters))]
	}
	return string(bytes)
}
