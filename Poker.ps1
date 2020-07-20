[string[]]$names = "Kate the Computer", "Izzy the Informer", "Evie the Evaluator", "Drew the Drawer", ""
[string[]]$finalHandValues = "high card", "pair", "two pair", "three of a kind", "straight", "flush", "full house", "four of a kind", "straight flush"
[string[]]$faces = "deuce", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "jack", "queen", "king", "ace"
[string[]]$suits = "hearts", "diamonds", "clubs", "spades"

class Deck {
    $faces = "deuce", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "jack", "queen", "king", "ace"
    $suits = "hearts", "diamonds", "clubs", "spades"
    [string[]]MakeDeck() {
        $deck = @("") * 52
        $count = 0
        for ($i = 0; $i -lt $this.faces.Length; $i++) {
            for ($j = 0; $j -lt $this.suits.Length; $j++) {
                
                $word = $this.faces[$i] + " of " + $this.suits[$j]
                $word
                $deck[$count] = $word
                $count++
            }
        }
        $deck -join " "
        return $deck
    }
}
$newDeck = [Deck]::new().MakeDeck() | Sort-Object { Get-Random }

class PlayerName {
    [string]GetName() {
        Write-Host "*****     Five Card Stud     *****"
        Write-Host ""
        $yourName = Read-host "What's your name"
        Write-Host ""
        Write-Host "Welcome to Five Card Stud, $yourName!"
        Write-Host ""
        return $yourName
    }  
}
class WelcomeToPoker {
    DisplayOpening() {
        [string[]]$names = "Kate the Computer", "Izzy the Informer", "Evie the Evaluator", "Drew the Drawer"
        Write-Host "Today you'll be playing with the likes of:"
        Start-Sleep -s 0.8
        Write-Host "`t" + $names[0]
        Start-Sleep -s 0.8
        Write-Host "`t`t" + $names[1]
        Start-Sleep -s 0.8
        Write-Host "`t`t`t" + $names[2]
        Start-Sleep -s 0.8
        Write-Host "`t`t`t`t ** AND **"
        Start-Sleep -s 0.8
        Write-Host "`t`t`t`t`t" + $names[3] + "`n"
        $response = Read-Host "Do you need a refresher on how to play Five Card Stud? (y/n)"
        if ($response -eq "y") {
            open "https://en.wikipedia.org/wiki/Five-card_stud"
        }
        Write-Host "OK then let's begin"
    }
}
function isHighCard($dataHand) {
    $isHighCard = $true
    $i = 0
    while ($i -lt 13) {
        if ($dataHand[$i] -gt 1) {
            $isHighCard = $false
        }
        $i++
    }
    $highCard = 0
    $j = 0
    while ($j -lt 13 -and $isHighCard -eq $true) {
        if ($dataHand[$j] -eq 1 -and $j -ge $highCard) {
            $highCard = $j
        }
        $j++
    }
    if ($isHighCard -eq $true) {
        $status = @($true, $highCard)
        return $status
    }
    else {
        $status = @($false, $highCard)
        return $status
    }
}
function isPair($dataHand) {
    $isAPair = $false
    $i = 0
    while ($i -lt 13) {
        if ($dataHand[$i] -eq 2) {
            $isAPair = $true
        }
        $i++
    }
    $highCard = 0
    $j = 0
    while ($j -lt 13 -and $isAPair -eq $true) {
        if ($dataHand[$j] -eq 2 -and $j -ge $highCard) {
            $highCard = $j
        }
        $j++
    }
    if ($isAPair -eq $true) {
        $status = @($true, $highCard)
        return $status
    }   

    else {
        $status = @($false)
        return $status
    }
}
function isTwoPair($dataHand) {
    $facesOfPairs = @(0, 0)
    $isATwoPair = $false
    $switch = 0
    $i = 0
    while ($i -lt 13) {
        if ($dataHand[$i] -eq 2) {
            $facesOfPairs[$switch] = $i
            $switch++
        }
        $i++
    }
    if ($facesOfPairs.Length -eq 2 -and $facesOfPairs[1] -ne 0) {
        $isATwoPair = $true
    }
    if ($isATwoPair -eq $true) {
        $status = @($true, $facesOfPairs[1])
        return $status
    }
    else {
        $status = @($false)
        return $status
    }
}
function isThreeOfAKind($dataHand) {
    $isAThreeOfAKind = $false
    $i = 0
    while ($i -lt 13) {
        if ($dataHand[$i] -eq 3) {
            $isAThreeOfAKind = $true
        }
        $i++
    }
    $highCard = 0
    $j = 0
    while ($j -lt 13) {
        if ($dataHand[$j] -eq 3) {
            $highCard = $j
        }
        $j++
    }
    if ($isAThreeOfAKind -eq $true) {
        $status = @($true, $highCard)
        return $status
    }
    else {
        $status = @($false)
        return $status
    }
}
function isStraight($dataHand) {
    $i = 0
    while ($i -lt 8) {
        if ($dataHand[$i] -eq 1 -and $dataHand[$i + 1] -eq 1 -and $dataHand[$i + 2] -eq 1 -and $dataHand[$i + 3] -eq 1 -and $dataHand[$i + 4] -eq 1) {
            $status = @($true, ($i + 4))
            return $status
        }
        $i++
    }
    $status = @($false)
    return $status
}
function isFlush($dataHand) {
    $isAFlush = $false
    $i = 16
    while ($i -ge 13) {
        if ($dataHand[$i] -eq 5) {
            $isAFlush = $true
        }
        $i--
    }
    $highCard = 0
    $j = 0
    while ($j -lt 13 -and $isAFlush -eq $true) {
        if ($dataHand[$j] -eq 1 -and $j -ge $highCard) {
            $highCard = $j
        }
        $j++
    }
    if ($isAFlush -eq $true) {
        $status = @($true, $highCard)
        return $status
    }
    else {
        $status = @($false)
        return $status
    }
}
function isFullHouse($dataHand) {
    $isAFullHouse = $false
    $numThreeKind = 0
    $numPair = 0
    $i = 0
    while ($i -lt 13) {
        if ($dataHand[$i] -eq 3) {
            $numThreeKind++
        }
        elseif ($dataHand[$i] -eq 2) {
            $numPair++
        }
        $i++
    }
    if ($numThreeKind -eq 1 -and $numPair -eq 1) {
        $isAFullHouse = $true
    }
    $highCard = 0
    $j = 0
    while ($j -lt 13 -and $isAFullHouse -eq $true) {
        if (($dataHand[$j] -eq 2 -or $dataHand[$j] -eq 3) -and $j -ge $highCard) {
            $highCard = $j
        }
        $j++
    }
    if ($isAFullHouse -eq $true) {
        $status = @($true, $highCard)
        return $status
    }
    else {
        $status = @($false)
        return $status
    }
}
function isFourOfAKind($dataHand) {
    $isAFourOfAKind = $false
    $i = 0
    while ($i -lt 13) {
        if ($dataHand[$i] -eq 4) {
            $isAFourOfAKind = $true
        }
        $i++
    }
    $highCard = 0
    $j = 0
    while ($j -lt 13 -and $isAFourOfAKind -eq $true) {
        if ($dataHand[$j] -eq 4 -and $j -ge $highCard) {
            $highCard = $j
        }
        $j++
    }
    if ($isAFourOfAKind -eq $true) {
        $status = @($true, $highCard)
        return $status
    }
    else {
        $status = @($false)
        return $status
    }
}
function isStraightFlush($dataHand) {
    $isALocalFlush = $false
    $isALocalStraight = $false
    $highCard = 0
    $i = 16
    while ($i -ge 13) {
        if ($dataHand[$i] -eq 5) {
            $isALocalFlush = $true
        }
        $i--
    }
    if ($isALocalFlush -eq $true) {
        $j = 0
        while ($j -lt 8) {
            if ($dataHand[$j] -eq 1 -and $dataHand[$j + 1] -eq 1 -and $dataHand[$j + 2] -eq 1 -and $dataHand[$j + 3] -eq 1 -and $dataHand[$j + 4] -eq 1) {
                $isALocalStraight = $true
                $highCard = ($j + 4)
            }
            $j++
        }
    }
    if ($isALocalFlush -eq $true -and $isALocalStraight -eq $true) {
        $status = @($true, $highCard)
        return $status
    }
    else {
        $status = @($false)
        return $status
    }
}
function determineWhatIsInAHand($hand) {
    [string[]]$faces = "deuce", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "jack", "queen", "king", "ace"
    [string[]]$suits = "hearts", "diamonds", "clubs", "spades"
    $face_organization = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # deuce, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    $suit_organization = 0, 0, 0, 0 #"hearts", "diamonds", "clubs", "spades"
    foreach ($card in $hand) {
        $i = 0
        while ($i -lt $faces.Length) {
            if ($card.StartsWith($faces[$i])) {
                $face_organization[$i] += 1
            }
            $i++
        }
        $j = 0
        while ($j -lt $suits.Length) {
            if ($card.EndsWith($suits[$j])) {
                $suit_organization[$j] += 1
            }
            $j++
        }
    }
    $combination = $face_organization + $suit_organization
    return $combination
}  
function determineHandRanking($hand) {
    $handValues = $false, $false, $false, $false, $false, $false, $false, $false, $false
    $status = isStraightFlush($hand)
    if ($status[0] -eq $true) {
        $handValues[8] = $true
        $handVal = @(8, $status[1]) 
        return $handVal
    }

    $status = isFourOfAKind($hand)
    if ($status[0] -eq $true) {
        $handValues[7] = $true
        $handVal = @(7, $status[1]) 
        return $handVal
    }

    $status = isFullHouse($hand)
    if ($status[0] -eq $true) {
        $handValues[6] = $true
        $handVal = @(6, $status[1])
        return $handVal
    }

    $status = isFlush($hand) 
    if ($status[0] -eq $true) {
        $handValues[5] = $true
        $handVal = @(5, $status[1]) 
        return $handVal
    }

    $status = isStraight($hand)
    if ($status[0] -eq $true) {
        $handValues[4] = $true
        $handVal = @(4, $status[1]) 
        return $handVal
    }

    $status = isThreeOfAKind($hand)
    if ($status[0] -eq $true) {
        $handValues[3] = $true
        $handVal = @(3, $status[1]) 
        return $handVal
    }
    $status = isTwoPair($hand)
    if ($status[0] -eq $true) {
        $handValues[2] = $true
        $handVal = @(2, $status[1]) 
        return $handVal
    }
    $status = isPair($hand)
    if ($status[0] -eq $true) {
        $handValues[1] = $true
        $handVal = @(1, $status[1]) 
        return $handVal
    }
    $status = isHighCard($hand)
    if ($status[0] -eq $true) {
        $handValues[0] = $true
        $handVal = @(0, $status[1]) 
        return $handVal
    }
}
function compareHandValuesAndDetermineWinner($handVals) {
    $highHand = 0
    $highCardInvolved = 0
    0..4 | foreach ($_) {
        if ($handVals[$_][0] -ge $highHand) {
            $highHand = $handVals[$_][0]
        }
    }
    0..4 | foreach ($_) {
        if ($handVals[$_][0] -eq $highHand) {
            if ($handVals[$_][1] -ge $highCardInvolved) {
                $highCardInvolved = $handVals[$_][1]
            }
        }
    }
    $winners = @()
    0..4 | foreach ($_) {
        if ($handVals[$_][0] -eq $highHand -and $handVals[$_][1] -eq $highCardInvolved) {
            $winners += $names[$_]
        }
    }
    $winningString = ""
    if ($winners.Length -gt 1) {
        0..($winners.Length - 1) | foreach ($_) {
            $winningString += $winners[$_] + " and "
        }
        $winningString += $winners[-1]

    }
    else {
        $winningString += $winners[0]
    }
    Write-Host ""
    Write-Host $winningString "won. The high hand was a" $finalHandValues[$highHand] "with a" $faces[$highCardInvolved] "high card."
    Write-Host ""
    Write-Host "" 
    Write-Host "Here's what everyone else had:"
    Write-Host ""
    0..4 | foreach ($_) {
        if (!$winningString.Contains($names[$_])) {
            Start-Sleep -s 0.8
            $names[$_] + " : " + $finalHandValues[$handVals[$_][0]] 
        }
    }
    Write-Host "Nice game."
    Write-Host ""
}

function playGame {
    $name = [PlayerName]::new().GetName()
    [WelcomeToPoker]::new().DisplayOpening()
    $newDeck = [Deck]::new().MakeDeck() | Sort-Object { Get-Random }    
    $names[4] = $name

    $hands = @(), @(), @(), @(), @()
    $num_cards_dealt = 0
    while ($num_cards_dealt -lt 25) {
        $hands[$num_cards_dealt % 5] += $newDeck[$num_cards_dealt]
        $num_cards_dealt++
    }

    $cards = "a " + $hands[4][0] + ", a " + $hands[4][1] + ", a " + $hands[4][2] + ", a " + $hands[4][3] + ", and a " + $hands[4][4]
    Write-Host "OK, " $names[4] ", you've got:   " $cards
    Start-Sleep -s 3.8
    $dataHands = @(), @(), @(), @(), @()
    0..4 | foreach {
        $dataHands[$_] = determineWhatIsInAHand($hands[$_])
    }
    $handRankings = @(), @(), @(), @(), @()
    0..4 | foreach {
        $handRankings[$_] = determineHandRanking($dataHands[$_])
    }
    compareHandValuesAndDetermineWinner($handRankings)
}
playGame






