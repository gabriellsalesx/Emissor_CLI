//go:build !windows

package platform

// StandaloneConsole é sempre falso fora do Windows: em Linux/macOS o terminal
// não fecha sozinho ao encerrar o programa.
func StandaloneConsole() bool { return false }
