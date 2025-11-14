//
//  main.swift
//  DesafioAppleAcademy
//
//  Created by PAULO CESAR ROCHA RICARDO PEREIRA on 14/11/25.
//

import Foundation

var jogadorVidaMax = 100
var jogadorVida = 100
var jogadorAtaque = 20
var jogadorNivel = 1
var jogadorExp = 0

var aumentoInimigo = 0


print("====================================")
print(" Batalha pela Terra Sagrada")
print("====================================")

let iniciar = lerNumero("Iniciar batalha? (1 = sim, 0 = não)")

if iniciar == 1 {

    var vitorias = 0

    while true {

        print("\n========== BATALHA \(vitorias + 1) ==========")

        let venceu = batalha()

        if venceu {
            print("\nVocê venceu!")

            vitorias += 1
            ganharExp(50)

            aumentoInimigo += 1

            print("\nO inimigo ficará mais forte na próxima batalha!")

            let continuar = lerNumero("\nDeseja lutar novamente? (1 = sim, 0 = sair)")
            if continuar == 0 {
                break
            }

            jogadorVida = jogadorVidaMax

        } else {

            print("\nVocê perdeu a batalha!")

            let tentarDeNovo = lerNumero("Deseja tentar novamente? (1 = sim, 0 = sair)")
            if tentarDeNovo == 1 {
                jogadorVida = jogadorVidaMax
                continue
            } else {
                break
            }
        }
    }

    print("\nFim do jogo! Vitórias totais: \(vitorias)")

} else {
    print("Programa encerrado.")
}


func lerNumero(_ texto: String) -> Int {
    print(texto, terminator: " ")
    return Int(readLine() ?? "") ?? 0
}

func batalha() -> Bool {

    var inimigoNivel = jogadorNivel + aumentoInimigo
    var inimigoVida = 75 + (inimigoNivel * 25)
    var inimigoAtaque = 6 + (inimigoNivel * 5)

    print("\nUm inimigo nível \(inimigoNivel) apareceu!")
    print("Vida do inimigo: \(inimigoVida)")

    repeat {

        print("\nSua vida: \(jogadorVida) / \(jogadorVidaMax)")
        print("Vida do inimigo: \(inimigoVida)")
        print("""
        Escolha sua ação:
        1 - Atacar
        2 - Defender
        3 - Curar
        0 - Fugir
        """)

        let escolha = lerNumero("Digite: ")

        switch escolha {

        case 0:
            print("\nVocê fugiu!")
            return false

        case 1:
            let dano = Int.random(in: jogadorAtaque...(jogadorAtaque + 5))
            inimigoVida -= dano
            print("Você atacou e causou \(dano) de dano!")

        case 2:
            print("Você se defendeu!")

        case 3:
            let cura = Int.random(in: 10...20)
            jogadorVida = min(jogadorVida + cura, jogadorVidaMax)
            print("Você se curou em \(cura) de vida!")

        default:
            print("Opção inválida!")
            continue
        }

        if inimigoVida <= 0 {
            return true
        }
        
        var danoInimigo = Int.random(in: inimigoAtaque...(inimigoAtaque + 4))
        if escolha == 2 {
           danoInimigo /= 2
        }


        jogadorVida -= inimigoAtaque
        print("O inimigo causou \(inimigoAtaque) de dano!")

        if jogadorVida <= 0 {
            return false
        }

    } while jogadorVida > 0 && inimigoVida > 0

    return inimigoVida <= 0
}

func ganharExp(_ valor: Int) {
    jogadorExp += valor
    print("Você ganhou \(valor) EXP! (Total: \(jogadorExp))")

    let expNecessaria = jogadorNivel * 10

    if jogadorExp >= expNecessaria {
        jogadorNivel += 1
        jogadorExp = 0

        jogadorVidaMax += 20
        jogadorAtaque += 10
        jogadorVida = jogadorVidaMax

        print("\nPARABÉNS! Subiu para o nível \(jogadorNivel)!")
        print("Atributos melhorados e vida restaurada!")
    }
}

