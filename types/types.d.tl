global _: any

global unpack: function<T>({T}, number, number): T...

local record api
  record UserCmdParams
    args: string
    bang: boolean
    line1: integer
    line2: integer
    range: integer
    count: number
    reg: string
    mods: string

    record Mods
      browse       : boolean
      confirm      : boolean
      emsg_silent  : boolean
      hide         : boolean
      keepalt      : boolean
      keepjumps    : boolean
      keepmarks    : boolean
      keeppatterns : boolean
      lockmarks    : boolean
      noautocmd    : boolean
      noswapfile   : boolean
      sandbox      : boolean
      silent       : boolean
      tab          : integer
      verbose      : integer
      vertical     : boolean

      enum Split ''
        'aboveleft'
        'belowright'
        'topleft'
        'botright'
      end

      split : Split
    end
    smods: Mods
  end

  record UserCmdOpts
    nargs: string|integer
    range: boolean|string|integer
    count: boolean|integer
    addr: string
    bang: boolean
    bar: boolean
    register: boolean
    force: boolean
    desc: string
    complete: string|function(arglead: string, line: string): {string}
  end
  nvim_create_user_command: function(string, function(UserCmdParams), UserCmdOpts)

  record GetExtmarOpts
    limit: integer
    details: boolean
  end

  nvim_create_namespace: function(string): integer

  record AugroupOpts
    clear: boolean
  end

  nvim_create_augroup: function(string, AugroupOpts): integer

  record AutoCmdOpts
    callback: function()
    command: string
    group: string
    pattern: string|{string}
    once: boolean
    nested: boolean
    desc: string
    buffer: integer
  end

  nvim_create_autocmd: function(string|{string}, AutoCmdOpts): integer
end

global record vim
  api: api
  record fn
    iconv: function(string, string, string): string
    line: function(string): integer
    join: function({any}, string): string
    getpos: function(string): {integer}
    executable: function(string): integer
    expand: function(string): string
    foldclosed: function(integer): integer
    foldclosedend: function(integer): integer
    getcwd: function(): string
    input: function(string, string): string

    record QFItem
      bufnr: integer
      filename: string
      lnum: integer
      nr: integer
      text: string
      type: string
    end

    record QFWhat
      context: any
      efm: string
      id: integer
      idx: integer
      items: {QFItem}
      lines: {string}
      nr: integer
      quickfixtextfunc: string
      title: string
    end

    setqflist: function(list: {QFItem}, action: string, what: QFWhat)
    setloclist: function(nr: integer, list: {QFItem}, action: string, what: QFWhat)

    sign_unplace: function(string, {string:any})
    sign_place: function(number, string, string, string | number, {string:any})

    record SignPlaceItem
      buffer: integer
      group: string
      id: integer
      lnum: integer
      name: string
      priority: integer
    end
    sign_placelist: function({SignPlaceItem})
    sign_getdefined: function(string): table

    record SignPlacedInfo
      bufnr: integer
      record SignPlacedSigns
        id: integer
        name: string
        group: string
        lnum: integer
        priority: integer
      end
      signs: {SignPlacedSigns}
    end
    sign_getplaced: function(integer, table): {SignPlacedInfo}

    sign_define: function(string, table): number
    sign_undefine: function(string): number
    strdisplaywidth: function(string, integer): integer
    stridx: function(haystack: string, needle: string, start: integer): integer
    string: function(any): string
    tempname: function(): string
    type: function(any): integer
  end

  cmd: function(string): any

  record g
    colors_name: string
  end

  record opt
    background: string
  end

  record loop
    cwd: function(): string
    record Timer
      userdata

      start: function(Timer, number, number, function): number
      stop: function(Timer): number
      close: function(Timer): number
      again: function(Timer): number
      set_repeat: function(Timer, number): number
      get_repeat: function(Timer): number
      get_due_in: function(Timer): number
    end
    hrtime: function(): number
    new_timer: function(): Timer | string
    timer_start: function(Timer, integer, integer, function()): integer | string

    new_fs_event: function()

    record FSPollObj
      userdata
      close: function(FSPollObj)
      start: function(FSPollObj, string, integer, function)
      stop: function(FSPollObj)
      getpath: function(FSPollObj): string
    end
    new_fs_poll: function(): FSPollObj | string

    record FsStatRet
      dev : number
      mode : number
      nlink : number
      uid : number
      gid : number
      rdev : number
      ino : number
      size : number
      blksize : number
      blocks : number
      flags : number
      gen : number
      record atime
        sec : number
        nsec : number
      end
      record mtime
        sec : number
        nsec : number
      end
      record ctime
        sec : number
        nsec : number
      end
      record birthtime
        sec : number
        nsec : number
      end
      type : string
    end

    fs_stat: function(string, function): FsStatRet

    fs_realpath: function(string): string

    new_tcp: function()

    sleep: function(integer)

    record Handle
      userdata

      close: function(Handle)
      is_closing: function(Handle): boolean | string
    end

    record Pipe
      userdata

      close: function(Pipe)
      is_closing: function(Pipe): boolean | string
      read_start: function(Pipe, err: any, data: string)
      read_stop: function(Pipe)
      write: function(Pipe, string, function())

      open: function(any)
    end

    record Process
      userdata

      close: function(Process)
    end

    record SpawnOpts
      stdio: {Pipe, Pipe, Pipe}
      args: {string}
      cwd: string
      env: {string}
    end

    spawn: function(string, SpawnOpts, function(integer, integer)): Process, integer

    read_start: function(Pipe, function)
    new_pipe: function(boolean): Pipe | string
    shutdown: function(any, function)
    close: function(any, function)

    record WorkCtx
      queue: function(WorkCtx, ...:any)
    end

    new_work: function(function, function): WorkCtx
  end

  in_fast_event: function(): boolean

  list_extend: function<T>({T}, {T}, integer, integer): {T}
  list_slice: function<T>({T}, integer, integer): {T}

  record keymap
    record Options
      buffer: boolean|integer
      expr: boolean
    end
    set: function(string|{string}, string, string|function, Options)
  end

  record log
    record levels
      WARN: integer
      ERROR: integer
      INFO: integer
      DEBUG: integer
    end
  end
  notify: function(string, integer, table)
  pretty_print: function(any)

  split: function(string, string): {string}
  split: function(string, string, boolean): {string}

  gsplit: function(string, string, boolean): function(): string

  pesc: function(string): string

  startswith: function(string, string): boolean
  endswith: function(string, string): boolean

  schedule_wrap: function(function()): function()
  schedule_wrap: function(function(...:any): any...): function(...:any): any...

  schedule: function(function)
  validate: function({string:{any}})
  trim: function(string): string

  enum ExtendBehavior
    'error'
    'keep'
    'force'
  end

  tbl_add_reverse_lookup: function<K,I>({K:I}): {I:K}
  tbl_deep_extend: function(ExtendBehavior, table, table, ...: table): table

  tbl_extend: function(ExtendBehavior, table, table, ...: table): table

  tbl_map: function(function, table): table

  tbl_keys: function(table): table

  tbl_filter: function((function(any): boolean), table): table

  tbl_count: function(table): integer

  tbl_isempty: function(table): boolean

  tbl_islist: function(table): boolean

  tbl_contains: function(table, any): boolean

  record InspectOptions
    depth: number
    newline: string
    indent: string
    process: function
  end
  record inspect
    METATABLE: any
    KEY: any
    metamethod __call: function(inspect, any, InspectOptions): string
    metamethod __call: function(inspect, any): string
  end
end
