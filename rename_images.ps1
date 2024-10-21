# Pergunta ao usuário qual pasta usar
$folderPath = Read-Host "Digite o caminho da pasta que contém as imagens e subpastas"

# Verifica se a pasta existe
if (-Not (Test-Path -Path $folderPath)) {
    Write-Host "O caminho especificado não existe. Por favor, tente novamente." -ForegroundColor Red
    exit
}

# Verifica se a subpasta "idle" existe e renomeia os arquivos nela
$idlePath = Join-Path -Path $folderPath -ChildPath "idle"
if (Test-Path -Path $idlePath) {
    Get-ChildItem -Path $idlePath -Filter "*.png" | ForEach-Object {
        $newName = "idle_" + $_.Name
        Rename-Item -Path $_.FullName -NewName $newName
    }
    Write-Host "Arquivos renomeados na subpasta 'idle'." -ForegroundColor Green
} else {
    Write-Host "A subpasta 'idle' não existe. Nenhum arquivo será renomeado na subpasta 'idle'." -ForegroundColor Yellow
}

# Define uma função para adicionar prefixos específicos em subpastas
function Add-PrefixToSubfolder($folderPath, $subfolder, $prefix) {
    $fullPath = Join-Path -Path $folderPath -ChildPath $subfolder
    if (Test-Path $fullPath) {
        Get-ChildItem -Path $fullPath -Filter "*.png" | ForEach-Object {
            $newName = $prefix + $_.Name
            Rename-Item -Path $_.FullName -NewName $newName
        }
        Write-Host "Arquivos renomeados na subpasta '$subfolder'." -ForegroundColor Green
    } else {
        Write-Host "A subpasta '$subfolder' não existe." -ForegroundColor Yellow
    }
}

# Adiciona os prefixos nas subpastas especificadas
Add-PrefixToSubfolder -folderPath $folderPath -subfolder "up" -prefix "up_"
Add-PrefixToSubfolder -folderPath $folderPath -subfolder "down" -prefix "down_"
Add-PrefixToSubfolder -folderPath $folderPath -subfolder "left" -prefix "left_"
Add-PrefixToSubfolder -folderPath $folderPath -subfolder "right" -prefix "right_"

Write-Host "Renomeação concluída com sucesso." -ForegroundColor Green
