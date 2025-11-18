
      try {
        (function n({contextBridge:e,ipcRenderer:t}){if(!t)return;t.on("__ELECTRON_LOG_IPC__",(e,t)=>{window.postMessage({cmd:"message",...t})}),t.invoke("__ELECTRON_LOG__",{cmd:"getOptions"}).catch(e=>console.error(Error(`electron-log isn't initialized in the main process. Please call log.initialize() before. ${e.message}`)));let r={sendToMain(e){try{t.send("__ELECTRON_LOG__",e)}catch(r){console.error("electronLog.sendToMain ",r,"data:",e),t.send("__ELECTRON_LOG__",{cmd:"errorHandler",error:{message:r?.message,stack:r?.stack},errorName:"sendToMain"})}},log(...e){r.sendToMain({data:e,level:"info"})}};for(let e of["error","warn","info","verbose","debug","silly"])r[e]=(...t)=>r.sendToMain({data:t,level:e});if(e&&process.contextIsolated)try{e.exposeInMainWorld("__electronLog",r)}catch{}"object"==typeof window?window.__electronLog=r:__electronLog=r})(require('electron'));
      } catch(e) {
        console.error(e);
      }
    