from pathlib import Path
from time import sleep
from typing import Any
from typing import Callable


class AttrDict(dict):
    def __getattribute__(self, name):
        try:
            attrib = super().__getattribute__(name)
        except AttributeError:
            attrib = super().__getitem__(name)
        return attrib

    def __setattr__(self, name, value):
        try:
            super().__getattribute__(name)
        except AttributeError:
            super().__setitem__(name, value)
        else:
            super().__setattr__(name, value)

    def __delattr__(self, name):
        try:
            super().__delattr__(name)
        except AttributeError:
            super().__delitem__(name)


def get_dir_auto_id(dir_path_str: str) -> str:
    dir_path = Path(dir_path_str)
    id_file_path = dir_path.joinpath(".next_id")
    return get_auto_id(id_file_path)


def get_auto_id(id_file_path: Path) -> str:
    id_temp_file_path = Path(id_file_path.as_posix() + "~")

    if not id_file_path.exists() and not id_temp_file_path.exists():
        id_file_path.parent.mkdir(exist_ok=True, parents=True)
        id_file_path.write_text("0")

    for tries in range(10):
        try:
            id_file_path.rename(id_temp_file_path)
        except FileNotFoundError:
            sleep(0.01)
            continue
        break
    else:
        raise OSError(f"can't access {id_file_path!s} to get auto id")

    auto_id = id_temp_file_path.read_text().strip()
    next_id = str(hex(int(auto_id, 16) + 1)[2:])
    id_temp_file_path.write_text(next_id)
    id_temp_file_path.rename(id_file_path)

    return f"{auto_id:>04}"


def unpack_args(base_func: Callable) -> Callable:

    def args_accessor(
            *args,
            **kwargs,
    ) -> Any:
        pass  # TODO

    return args_accessor


def neget(obj, default_obj=None, nobj=""):
    """Not Equal get (for default: Not empty string get)

    :return: obj if obj != nobj else default_obj
    """
    return obj if obj != nobj else default_obj


def niget(obj, default_obj=None, nobj=None):
    """Not Is get (for default: Not is None get)

    :return: `obj` if it is not `nobj` else `default_obj`
    """
    return obj if obj is not nobj else default_obj
