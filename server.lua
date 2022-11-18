db = dbConnect("sqlite","marketpaneldata.db")
local tepki
local vipturu
local oyuncununmjsi = 0
local hesap
local account
local aracturu
local jetons
local oyuncuiki
local miktari
local jetonlari
local secilens 
local tepkiveren
local tepki 
local oyuncuac
local nametags
local bildirims

if db then
    outputDebugString("[Market Paneli] Database ile bağlantı başarılı.")
end

local oyuncu
function yenile(adam)
    oyuncu = adam
    dbQuery(yenile2, db, "SELECT * FROM veriler")
end

function yenile2(veris)
    local secim = dbPoll(veris,0)
    local mjsi = 0
    hesap = getAccountName(getPlayerAccount(oyuncu))
    for i,isim in pairs(secim) do 
        local acadi = isim.oyuncu
        if tostring(hesap) == tostring(acadi) then
            mjsi = isim.mjmiktar
        end
    end  
    triggerClientEvent(oyuncu,"yenile",oyuncu,mjsi)
end

addEvent("vipsatinal",true)
addEventHandler("vipsatinal",root, function(vip)
    hesap = getAccountName(getPlayerAccount(source))
    vipturu = vip
    tepki = source
    dbQuery(vipsatinalma, db, "SELECT * FROM veriler")
end)

function vipsatinalma(veriler)
    local secim = dbPoll(veriler,0)
    oyuncuvarmi = false
    for i,isim in pairs(secim) do 
        local acadi = isim.oyuncu
        if tostring(hesap) == tostring(acadi) then
            oyuncuvarmi = true
            oyuncununmjsi = isim.mjmiktar
        end
    end
    if oyuncuvarmi == true then
        if tostring(vipturu) == "altinvip" then
            if oyuncununmjsi >= 60 then
                if not isObjectInACLGroup("user." ..hesap, aclGetGroup("GoldVip")) then
                    exports.hud:dm("#FFFFFFBaşarıyla #FF7F00Gold V.I.P #ffffffSatın Aldınız! Alışveriş için teşekkürler.", tepki, 255,0,0, true)
                    aclGroupAddObject(aclGetGroup("GoldVip"), "user."..hesap)
                    oyuncununmjsi = oyuncununmjsi - 60
                    mjyenile4(hesap)
                    yenile(tepki)
                 else
                    exports.hud:dm("#ffffffZaten Altın Vip olduğunuz için, #ff7f00satın alma işlemi #ffffffiptal edildi.",tepki,255,127,0,true)
                end
             else
                exports.hud:dm("#ffffffMaalesef Yeterli jetona sahip olmadığınız için, #ff7f00satın alma işlemi #ffffffiptal edildi.",tepki,255,127,0,true)
            end
         elseif vipturu == "gumusvip" then
            if oyuncununmjsi >= 40 then
                if not isObjectInACLGroup("user." ..hesap, aclGetGroup("SilverVip")) then
                    exports.hud:dm("#FFFFFFBaşarıyla #FF7F00Gümüş V.I.P #ffffffSatın Aldınız! Alışveriş için teşekkürler.", tepki, 255,0,0, true)
                    aclGroupAddObject(aclGetGroup("SilverVip"), "user."..hesap)
                    oyuncununmjsi = oyuncununmjsi - 40
                    mjyenile4(hesap)
                    yenile(tepki)
                 else
                    exports.hud:dm("#ffffffZaten Gümüş Vip olduğunuz için, #ff7f00satın alma işlemi #ffffffiptal edildi.",tepki,255,127,0,true)
                end
             else
                exports.hud:dm("#ffffffMaalesef Yeterli jetona sahip olmadığınız için, #ff7f00satın alma işlemi #ffffffiptal edildi.",tepki,255,127,0,true)
            end
         elseif vipturu == "bronzvip" then
            if oyuncununmjsi >= 20 then
                if not isObjectInACLGroup("user." ..hesap, aclGetGroup("BronzVip")) then
                    exports.hud:dm("#FFFFFFBaşarıyla #FF7F00Bronz V.I.P #ffffffSatın Aldınız! Alışveriş için teşekkürler.", tepki, 255,0,0, true)
                    aclGroupAddObject(aclGetGroup("BronzVip"), "user."..hesap)
                    oyuncununmjsi = oyuncununmjsi - 20
                    mjyenile4(hesap)
                    yenile(tepki)
                 else
                    exports.hud:dm("#ffffffZaten Bronz Vip olduğunuz için, #ff7f00satın alma işlemi #ffffffiptal edildi.",tepki,255,127,0,true)
                end
             else
                exports.hud:dm("#ffffffMaalesef Yeterli jetona sahip olmadığınız için, #ff7f00satın alma işlemi #ffffffiptal edildi.",tepki,255,127,0,true)
            end
        end
     elseif oyuncuvarmi == false then
        exports.hud:dm("#ffffffMaalesef herhangi bir jetona sahip olmadığınız için, #ff7f00satın alma işlemi #ffffffiptal edildi.",tepki,255,127,0,true)
    end
end

function mjyenile4(kadi)
    dbExec(db, "UPDATE veriler SET mjmiktar = ? WHERE oyuncu = ?",oyuncununmjsi,kadi)
    exports.hud:dm("#FF7F00[Finsansal Güncelleme] #ffffffKalan MJ Miktarı: "..oyuncununmjsi.." Jeton Yüklemek için /dc geliniz.",tepki,255,128,0,true)
end

function mjyenile(kadi)
    dbExec(db, "UPDATE veriler SET mjmiktar = ? WHERE oyuncu = ?",oyuncununmjsi,kadi)
    exports.hud:dm("#FF7F00[Finsansal Güncelleme] #ffffffKalan MJ Miktarı: "..oyuncununmjsi.." Jeton Yüklemek için /dc geliniz.",bildirims,255,128,0,true)
end

function mjyenile2(kadi)
    dbExec(db, "UPDATE veriler SET mjmiktar = ? WHERE oyuncu = ?",jetons,kadi)
    exports.hud:dm("#FF7F00[Finsansal Güncelleme] #ffffffKalan MJ Miktarı: "..jetons.." Jeton Yüklemek için /dc geliniz.",tepki,255,128,0,true)
end

function mjyenile3(kadi)
    dbExec(db, "UPDATE veriler SET mjmiktar = ? WHERE oyuncu = ?",jetonlari,kadi)
    exports.hud:dm("#FF7F00[Finsansal Güncelleme] #ffffffKalan MJ Miktarı: "..jetonlari.." Jeton Yüklemek için /dc geliniz.",oyuncuiki,255,128,0,true)
end

addEvent("aracsatinal",true)
addEventHandler("aracsatinal",root,function(secilen)
    account = getAccountName(getPlayerAccount(source))
    tepki = source
    aracturu = secilen
    dbQuery(aracsatinalma, db, "SELECT * FROM veriler")
end)

function aracsatinalma(gelenler)
    local secimler = dbPoll(gelenler,0)
    hesabivarmi = false
    for i,isim in pairs(secimler) do 
        local acadi = isim.oyuncu
        if tostring(account) == tostring(acadi) then
            hesabivarmi = true
            jetons = isim.mjmiktar
        end
    end
    if hesabivarmi == true then
        if aracturu == 0 then
            if jetons >= 300 then
                arac = 0
                jetons = jetons - 300
                mjyenile2(account)
                exports.hud:dm("#FFFFFFBaşarıyla #FF7F00Bugatti Chiron #ffffffSatın Aldınız! Alışveriş için teşekkürler.", tepki, 255,0,0, true)
               triggerClientEvent(tepki,"arac1",tepki)
               yenile(tepki)
            end
         elseif aracturu == 1 then
            if jetons >= 250 then
                arac = 1
                jetons = jetons - 250
                mjyenile2(account)
                exports.hud:dm("#FFFFFFBaşarıyla #FF7F00Ferrari F8 #ffffffSatın Aldınız! Alışveriş için teşekkürler.", tepki, 255,0,0, true)
                triggerClientEvent(tepki,"arac2",tepki)
                yenile(tepki)
            end
         elseif aracturu == 2 then
            if jetons >= 250 then
                arac = 2
                jetons = jetons - 250
                mjyenile2(account)
                exports.hud:dm("#FFFFFFBaşarıyla #FF7F00Lamborghibi Huracan #ffffffSatın Aldınız! Alışveriş için teşekkürler.", tepki, 255,0,0, true)
                triggerClientEvent(tepki,"arac3",tepki) 
                yenile(tepki)
            end
         elseif aracturu == 3 then
            if jetons >= 150 then
               arac = 3
               jetons = jetons - 150
               mjyenile2(account)
               exports.hud:dm("#FFFFFFBaşarıyla #FF7F00Rolls Royce Ghost #ffffffSatın Aldınız! Alışveriş için teşekkürler.", tepki, 255,0,0, true)
               triggerClientEvent(tepki,"arac4",tepki)
               yenile(tepki)
            end
         elseif aracturu == 4 then
            if jetons >= 100 then
                arac = 4
                jetons = jetons - 100
                mjyenile2(account)
                exports.hud:dm("#FFFFFFBaşarıyla #FF7F00Bentley Bentayga #ffffffSatın Aldınız! Alışveriş için teşekkürler.", tepki, 255,0,0, true)
                triggerClientEvent(tepki,"arac5",tepki)
                yenile(tepki)
            end
         elseif aracturu == 5 then
            if jetons >= 60 then
                arac = 5
                jetons = jetons - 60
                mjyenile2(account)
                exports.hud:dm("#FFFFFFBaşarıyla #FF7F00Mercedes E36 #ffffffSatın Aldınız! Alışveriş için teşekkürler.", tepki, 255,0,0, true)
                triggerClientEvent(tepki,"arac6",tepki)
                yenile(tepki)

            end
         end
     elseif hesabivarmi == false then
        exports.hud:dm("#ffffffMaalesef herhangi bir jetona sahip olmadığınız için, #ff7f00satın alma işlemi #ffffffiptal edildi.",tepki,255,127,0,true)
    end
end

addEvent("paraver",true)
addEventHandler("paraver",root,function(miktar)
    account = getAccountName(getPlayerAccount(source))
    oyuncuiki = source
    miktari = miktar
    dbQuery(paraveradama, db, "SELECT * FROM veriler")
end)

function paraveradama(veris)
    local secimleri = dbPoll(veris,0)
    local hesapi = false
    for i,isim in pairs(secimleri) do 
        local acadi = isim.oyuncu
        if tostring(account) == tostring(acadi) then
            hesapi = true
            jetonlari = isim.mjmiktar
        end
    end
    if hesapi == true then
       if miktari == 10 then
         if jetonlari >= 200 then
            jetonlari = jetonlari - 200
            mjyenile3(account)
            exports.hud:dm("#FFFFFFBaşarıyla oyun içi#FF7F00$10.000.000 #ffffffSatın Aldınız! Alışveriş için teşekkürler.", oyuncuiki, 255,0,0, true)
            givePlayerMoney(oyuncuiki,10000000)
            yenile(oyuncuiki)
         else
            exports.hud:dm("#FFFFFFMaalesef yeteri kadar #FF7F00Madde Jeton'unuz #ffffffBulunmamaktadır.", oyuncuiki, 255,0,0, true)
         end
        elseif miktari == 5 then
            if jetonlari >= 150 then
                jetonlari = jetonlari - 150
                mjyenile3(account)
                exports.hud:dm("#FFFFFFBaşarıyla oyun içi#FF7F00$5.000.000 #ffffffSatın Aldınız! Alışveriş için teşekkürler.", oyuncuiki, 255,0,0, true)
                givePlayerMoney(oyuncuiki,5000000)
                yenile(oyuncuiki)
             else
                exports.hud:dm("#FFFFFFMaalesef yeteri kadar #FF7F00Madde Jeton'unuz #ffffffBulunmamaktadır.", oyuncuiki, 255,0,0, true)
             end
            elseif miktari == 2 then
                if jetonlari >= 100 then
                    jetonlari = jetonlari - 100
                    mjyenile3(account)
                    exports.hud:dm("#FFFFFFBaşarıyla oyun içi#FF7F00$2.500.000 #ffffffSatın Aldınız! Alışveriş için teşekkürler.", oyuncuiki, 255,0,0, true)
                    givePlayerMoney(oyuncuiki,2500000)
                    yenile(oyuncuiki)
                 else
                    exports.hud:dm("#FFFFFFMaalesef yeteri kadar #FF7F00Madde Jeton'unuz #ffffffBulunmamaktadır.", oyuncuiki, 255,0,0, true)
                 end
                elseif miktari == 1 then
                    if jetonlari >= 80 then
                        jetonlari = jetonlari - 80
                        mjyenile3(account)
                        exports.hud:dm("#FFFFFFBaşarıyla oyun içi#FF7F00$1.000.000 #ffffffSatın Aldınız! Alışveriş için teşekkürler.", oyuncuiki, 255,0,0, true)
                        givePlayerMoney(oyuncuiki,1000000)
                        yenile(oyuncuiki)
                     else
                        exports.hud:dm("#FFFFFFMaalesef yeteri kadar #FF7F00Madde Jeton'unuz #ffffffBulunmamaktadır.", oyuncuiki, 255,0,0, true)
                     end
                    elseif miktari == 500 then
                        if jetonlari >= 40 then
                            jetonlari = jetonlari - 40
                            mjyenile3(account)
                            exports.hud:dm("#FFFFFFBaşarıyla oyun içi#FF7F00$500.000 #ffffffSatın Aldınız! Alışveriş için teşekkürler.", oyuncuiki, 255,0,0, true)
                            givePlayerMoney(oyuncuiki,500000)
                            yenile(oyuncuiki)
                         else
                            exports.hud:dm("#FFFFFFMaalesef yeteri kadar #FF7F00Madde Jeton'unuz #ffffffBulunmamaktadır.", oyuncuiki, 255,0,0, true)
                         end
                        end
                    elseif hesapi == false then
                        exports.hud:dm("#ffffffMaalesef herhangi bir jetona sahip olmadığınız için, #ff7f00satın alma işlemi #ffffffiptal edildi.",oyuncuiki,255,127,0,true)     
    end
end
local mjmikt
local yapan
local ozabiminhesap

addCommandHandler("mjver",function(oyuncu,cmd,kisi,miktar)
    local hesapa = getAccountName ( getPlayerAccount (oyuncu) )
    if isObjectInACLGroup ("user."..hesapa, aclGetGroup ( "MGyonetim" ) ) then
    mjmikt = miktar
    yapan = oyuncu
    ozabiminhesap = kisi
    dbQuery(mjveradama, db, "SELECT * FROM veriler")
    else
        exports["solyazi"]:dm("#ffffffBu komutu yalnızca #ff7f00Üst Yönetim #ffffffkullanabilir.",oyuncu,255,127,0,true)
    end
end)

addEvent("yazdirhele",true)
addEventHandler("yazdirhele",root,function()
    yenile(source)
end)

function mjveradama(gelcanim)
    local secimleri = dbPoll(gelcanim,0)
    local hesabivarmi = false
    local verilecekmani = mjmikt
    local oncekimani
    for i,isim in pairs(secimleri) do 
        local acadi = isim.oyuncu
        if tostring(ozabiminhesap) == tostring(acadi) then
            hesabivarmi = true
            oncekimani = isim.mjmiktar
        end
    end
    if hesabivarmi == true then
        verilecekmani = oncekimani + verilecekmani
        dbExec(db, "UPDATE veriler SET mjmiktar = ? WHERE oyuncu = ?",verilecekmani,ozabiminhesap)
        exports["solyazi"]:dm("#ffffffİsmi yazılı oyuncuya #ff7f00"..mjmikt.." #ffffffMiktar MJ verildi",yapan,255,127,0,true)
    elseif hesabivarmi == false then
        dbExec(db, "INSERT INTO veriler (oyuncu, mjmiktar) VALUES (?,?)",ozabiminhesap,verilecekmani)
        exports["solyazi"]:dm("#ffffffİsmi yazılı oyuncuya #ff7f00"..mjmikt.." #ffffffMiktar MJ verildi",yapan,255,127,0,true)
    end
end

local alinacakmani
local yetkili
local gariban

addCommandHandler("mjal",function(oyuncu,cmd,kisi,miktar)
    local hesapa = getAccountName ( getPlayerAccount (oyuncu) )
    if isObjectInACLGroup ("user."..hesapa, aclGetGroup ( "Admin" ) ) then
    alinacakmani = miktar
    yetkili = oyuncu
    gariban = kisi
    dbQuery(mjaladama, db, "SELECT * FROM veriler")
    else
        exports["solyazi"]:dm("#ffffffBu komutu yalnızca #ff7f00Üst Yönetim #ffffffkullanabilir.",oyuncu,255,127,0,true)
    end
end)

function mjaladama(gelcanim)
    local secimleri = dbPoll(gelcanim,0)
    local hesabivarmi = false
    local alinacak = alinacakmani
    local oncekimani = 0
    for i,isim in pairs(secimleri) do 
        local acadi = isim.oyuncu
        if tostring(gariban) == tostring(acadi) then
            hesabivarmi = true
            oncekimani = isim.mjmiktar
        end
    end
    if hesabivarmi == true then
        if tonumber(alinacak) > tonumber(oncekimani) then
            exports["solyazi"]:dm("Almak istediğin miktar oyuncuda yok. Oyuncunun MJ miktarı: "..oncekimani,yetkili,255,127,0,true)
        else
        local toplam = oncekimani - alinacak
        dbExec(db, "UPDATE veriler SET mjmiktar = ? WHERE oyuncu = ?",toplam,gariban)
        exports["solyazi"]:dm("#ffffffİsmi yazılı oyuncudan #ff7f00"..alinacak.." #ffffffMiktar MJ kesildi.",yetkili,255,127,0,true)
        end
       elseif hesabivarmi == false then
        exports["solyazi"]:dm("#ffffffOyuncunun hiç MJ si bulunmamaktadır.",yetkili,255,127,0,true)
    end
end

local secilens 
local tepkiveren
local oyuncuac
local nametags

addEvent("ayricaliksatinal",true)
addEventHandler("ayricaliksatinal",root,function(gelen,textsa)
    secilens = gelen
    bildirims = source
    nametags = textsa
    oyuncuac = getPlayerAccount(source)
    tepkiveren = getAccountName(getPlayerAccount(source))
    dbQuery(ayricaliks, db, "SELECT * FROM veriler")
end)

function ayricaliks(veris)
    local secim = dbPoll(veris,0)
    for i,isim in pairs(secim) do 
        local acadi = isim.oyuncu
        if tostring(tepkiveren) == tostring(acadi) then
            oyuncununmjsi = isim.mjmiktar
        end
    end  
    if secilens == 0 then
        if tonumber(oyuncununmjsi) >= 15 then
            if getAccountData(oyuncuac,"Bonus15") == false then
            setAccountData(oyuncuac,"Bonus15",true)
            oyuncununmjsi = oyuncununmjsi - 15
            mjyenile(tepkiveren)
            yenile(bildirims)
            exports["hud"]:dm("#ffffffBaşarıyla #ff7f00Görevlerden %15 Bonus Para#ffffff Ayrıcalığını satın aldınız!",bildirims,255,127,0,true)
            else
                exports["hud"]:dm("#ffffffZaten #ff7f00Görevlerden %15 Bonus Para#ffffff Ayrıcalığına sahip olduğunuz için, işlem iptal edildi.",bildirims,255,127,0,true)
            end
        else
            exports["hud"]:dm("#ffffffYeterli #ff7f00MJ 'ye sahip#ffffffdeğilsiniz.",bildirims,255,127,0,true)
        end
      elseif secilens == 1 then
        if tonumber(oyuncununmjsi) >= 30 then
            if getAccountData(oyuncuac,"Bonus30") == false then
            setAccountData(oyuncuac,"Bonus30",true)
            oyuncununmjsi = oyuncununmjsi - 30
            mjyenile(tepkiveren)
            yenile(bildirims)
            exports["hud"]:dm("#ffffffBaşarıyla #ff7f00Görevlerden %30 Bonus Para#ffffff Ayrıcalığını satın aldınız!",bildirims,255,127,0,true)
            else
                exports["hud"]:dm("#ffffffZaten #ff7f00Görevlerden %30 Bonus Para#ffffff Ayrıcalığına sahip olduğunuz için, işlem iptal edildi.",bildirims,255,127,0,true)
            end
        else
            exports["hud"]:dm("#ffffffYeterli #ff7f00MJ 'ye sahip#ffffffdeğilsiniz.",bildirims,255,127,0,true)
        end
        elseif secilens == 2 then
            if tonumber(oyuncununmjsi) >= 45 then
                if getAccountData(oyuncuac,"Bonus45") == false then
                setAccountData(oyuncuac,"Bonus45",true)
                oyuncununmjsi = oyuncununmjsi - 45
                mjyenile(tepkiveren)
                yenile(bildirims)
                exports["hud"]:dm("#ffffffBaşarıyla #ff7f00Görevlerden %45 Bonus Para#ffffff Ayrıcalığını satın aldınız!",bildirims,255,127,0,true)
                else
                    exports["hud"]:dm("#ffffffZaten #ff7f00Görevlerden %45 Bonus Para#ffffff Ayrıcalığına sahip olduğunuz için, işlem iptal edildi.",bildirims,255,127,0,true)
                end
             else
                exports["hud"]:dm("#ffffffYeterli #ff7f00MJ 'ye sahip#ffffffdeğilsiniz.",bildirims,255,127,0,true)
             end
            elseif secilens == 3 then
			if yazilan ~= "" and #yazilan >= 4 and #yazilan <= 25 then
                if tonumber(oyuncununmjsi) >= 150 then
                    if getElementData(bildirims,"cargo") == nametags then
                        exports["hud"]:dm("#ffffffZaten #ff7f00Böyle bir NameTagınız #ffffffvar. Lütfen başka bir şey deneyin.",bildirims,255,127,0,true)
                    else
                        oyuncununmjsi = oyuncununmjsi - 150
                        mjyenile(tepkiveren)
                        yenile(bildirims)
                        if nametags == "Admin" or nametags == "ADMİN" or nametags == "Sunucu Sahibi" or nametags == "Kurucu" or nametags == "KURUCU" or nametags == "sw sahibi" then
                            exports["hud"]:dm("#ffffffBu NameTag 'ı almanız #ff7f00Yasak! #ffffffCeza olarak 150 MJ kesildi.",bildirims,255,127,0,true)
                            return 
                        end
                        setAccountData(oyuncuac, "ozelnametag", nametags)
                        exports["hud"]:dm("#ffffffBaşarıyla #ff7f00Özel NameTag 'a sahip #ffffffoldunuz. Satın alımınız için teşekkürler!",bildirims,255,127,0,true)
                    end
                else
                    exports["hud"]:dm("#ffffffYeterli #ff7f00MJ 'ye sahip#ffffffdeğilsiniz.",bildirims,255,127,0,true)
                end
				else 
				exports["hud"]:dm("#ffffffNameTag #ff7f004 harften daha uzun, 25 harften daha kısa #ffffffolmalı..",bildirims,255,127,0,true)
				end
            elseif secilens == 4 then
                if tonumber(oyuncununmjsi) >= 150 then
                    if getElementData(bildirims,"cargo") == nametags then
                        exports["hud"]:dm("#ffffffZaten #ff7f00Böyle bir NameTagınız #ffffffvar. Lütfen başka bir şey deneyin.",bildirims,255,127,0,true)
                    else
                        oyuncununmjsi = oyuncununmjsi - 150
                        mjyenile(tepkiveren)
                        yenile(bildirims)
                        if nametags == "Admin" or nametags == "ADMİN" or nametags == "Sunucu Sahibi" or nametags == "Kurucu" or nametags == "KURUCU" or nametags == "sw sahibi" then
                            exports["hud"]:dm("#ffffffBu NameTag 'ı almanız #ff7f00Yasak! #ffffffCeza olarak 150 MJ kesildi.",bildirims,255,127,0,true)
                            return 
                        end                        
                        local klani = getElementData(bildirims,"Clan")
                        if tostring(klani) == "" then exports["hud"]:dm("#ffffffHerhangi #ff7f00bir klanda #ffffffdeğilsiniz.",bildirims,255,127,0,true) return end
                        exports["nametag"]:klaneklename(bildirims,klani,nametags)
                        exports["hud"]:dm("#ffffffBaşarıyla #ff7f00Özel NameTag 'a sahip #ffffffoldunuz. Satın alımınız için teşekkürler!",bildirims,255,127,0,true)
                    end
                 else
                    exports["hud"]:dm("#ffffffYeterli #ff7f00MJ 'ye sahip#ffffffdeğilsiniz.",bildirims,255,127,0,true)
                end
            elseif secilens == 5 then
                if tonumber(oyuncununmjsi) >= 100 then
                    local klani = getElementData(bildirims,"Clan")
                    if tostring(klani) == "" then exports["hud"]:dm("#ffffffHerhangi #ff7f00bir klanda #ffffffdeğilsiniz.",bildirims,255,127,0,true) return end
                    exports["ozelmaas"]:maaseklename(bildirims,klani,35000)
                    oyuncununmjsi = oyuncununmjsi - 100
                    mjyenile(tepkiveren)
                    yenile(bildirims)
                    exports["hud"]:dm("#ffffffBaşarıyla #ff7f00Saatlik Klan Maaşı $35.000 #ffffffAyrıcalığını satın aldınız. Maaş her 30dk da bir verilmekte.",bildirims,255,127,0,true)
                else
                    exports["hud"]:dm("#ffffffYeterli #ff7f00MJ 'ye sahip#ffffffdeğilsiniz.",bildirims,255,127,0,true)
                end
            elseif secilens == 6 then
                if tonumber(oyuncununmjsi) >= 150 then
                    local klani = getElementData(bildirims,"Clan")
                    if tostring(klani) == "" then exports["hud"]:dm("#ffffffHerhangi #ff7f00bir klanda #ffffffdeğilsiniz.",bildirims,255,127,0,true) return end
                    exports["ozelmaas"]:maaseklename(bildirims,klani,50000)
                    oyuncununmjsi = oyuncununmjsi - 150
                    mjyenile(tepkiveren)
                    yenile(bildirims)
                    exports["hud"]:dm("#ffffffBaşarıyla #ff7f00Saatlik Klan Maaşı $50.000 #ffffffAyrıcalığını satın aldınız. Maaş her 30dk da bir verilmekte.",bildirims,255,127,0,true)
                else
                    exports["hud"]:dm("#ffffffYeterli #ff7f00MJ 'ye sahip#ffffffdeğilsiniz.",bildirims,255,127,0,true)
                end
    end

end