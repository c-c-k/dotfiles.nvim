use nvimo::mlua;

#[mlua::lua_module]
fn my_rs(lua: &mlua::Lua) -> mlua::Result<mlua::Table> {
    nvimo::init(lua)?;
    let my_rs = lua.create_table()?;

    Ok(my_rs)
}
