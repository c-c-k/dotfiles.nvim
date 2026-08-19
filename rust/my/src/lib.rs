use nvim::mlua;

#[mlua::lua_module]
fn my_rs(lua: &mlua::Lua) -> mlua::Result<mlua::Table> {
    nvim::init(lua)?;
    let my_rs = lua.create_table()?;

    Ok(my_rs)
}
