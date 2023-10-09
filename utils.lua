function Log(data)
    local file = io.open("log.txt", "a")  
    io.output(file)
    io.write(data)
    io.close(file)
end
function Status_Ok(name)
    local status, pkg = pcall(require, name)
    if not status then
        return nil
    end
    return pkg
end
