//go:build windows

package platform

import (
	"syscall"
	"unsafe"
)

var (
	kernel32                  = syscall.NewLazyDLL("kernel32.dll")
	procGetConsoleProcessList = kernel32.NewProc("GetConsoleProcessList")
)

// StandaloneConsole informa se o processo é o único dono do console (ou seja,
// foi aberto com duplo clique / atalho, e não a partir de um terminal já
// existente). Nesse caso o console fecha ao encerrar, então a CLI deve pausar
// para o usuário ler a última mensagem.
func StandaloneConsole() bool {
	var list [8]uint32
	r, _, _ := procGetConsoleProcessList.Call(uintptr(unsafe.Pointer(&list[0])), uintptr(len(list)))
	// 0 = falha; 1 = só este processo (duplo clique). >1 = há um shell pai.
	return r == 1
}
