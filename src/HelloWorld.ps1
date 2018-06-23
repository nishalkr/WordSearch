function Get-PSFiles()
{
 #Begin block execute once at the start of the function
  begin {$retval = "`tFile Name `t File Size(bytes) `r`n"}

    process {
    if ($_.Name -like "*.*")
    {
        #$retval += "`t$($_.FullName)" + "`t $($_.Length) `r`n" # This will return a single string.

        $SEL = Select-String -Path $_.FullName -Pattern File

        If ($SEL.Length -gt 0) 
            {
              $retval += "`t$($_.FullName)" +" -  Contains String" + " `r`n"
            }
            else
            {
              $retval += "`t$($_.FullName)" +" -  Not Contains String" + " `r`n"
            }
    }
  }
  
  end {return $retval}
}

Function Get-PSModifyDate($FilePath)
{
   

    Set-Location $FilePath

    $include = @("*.*","*.cshtml","*.cs","*.css","*.tt","*.edmx","*.svc","*.config");

    $Days = 2

     $time = (Get-Date).AddDays($Days * -1)

     $time

     Get-ChildItem -Path $FilePath    |  Where-Object {$_.LastWriteTime -gt $time} | Get-PSFiles 
}


Get-PSModifyDate -FilePath "C:\Nishal\Projects\VSCode\contentprovider-sample\src"